// This is your test publishable API key.
const stripe = Stripe("pk_test_51OADTuE2rkCMN6VCtvF0CSosbS4GWpCbapUY6bpfvTonxLIv7nQDQt5ZIIgmCMKaEEsGdODisbYvuehraj5ydG1X00OILYsn69");

initialize();

// Create a Checkout Session as soon as the page loads
async function initialize() {
  const response = await fetch("/create-embeded-checkout-session", {
    method: "POST",
  });

  const { clientSecret } = await response.json();

  const checkout = await stripe.initEmbeddedCheckout({
    clientSecret,
  });

  // Mount Checkout
  checkout.mount('#checkout');
}