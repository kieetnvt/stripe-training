// This is your test publishable API key.
const stripe = Stripe("pk_test_51OADTuE2rkCMN6VCtvF0CSosbS4GWpCbapUY6bpfvTonxLIv7nQDQt5ZIIgmCMKaEEsGdODisbYvuehraj5ydG1X00OILYsn69");

// The items the customer wants to buy
const items = [{ id: "xl-tshirt" }];

let elements;

initialize();

document
  .querySelector("#payment-form")
  .addEventListener("submit", handleSubmit);

// 1st, Fetches a payment intent and captures the client secret then mount into html dom
async function initialize() {
  const response = await fetch("/create-payment-intent", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ items }),
  });
  const { clientSecret } = await response.json();

  const appearance = {
    theme: 'flat',
  };

  elements = stripe.elements({ appearance, clientSecret });

  const cardNumber = elements.create("cardNumber");
  const cardExpiry = elements.create("cardExpiry");
  const cardCvc = elements.create("cardCvc");

  cardNumber.mount("#cc-number");
  cardExpiry.mount("#cc-expiration");
  cardCvc.mount("#cc-cvv");

}

async function handleSubmit(e) {
  e.preventDefault();
  console.log('elements...', elements)

  stripe.createToken(elements.getElement('cardNumber')).then(function(result) {
    console.log('result token...', result)
    const token = result.token.id

    fetch("/capture", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ token: token })
    }).then(function(result) {
      console.log('capture...', result)
      window.location = "http://localhost:3000/web-elements-success"
    });
  });
}

