// This is your test publishable API key.
const stripe = Stripe("pk_test_51OADTuE2rkCMN6VCtvF0CSosbS4GWpCbapUY6bpfvTonxLIv7nQDQt5ZIIgmCMKaEEsGdODisbYvuehraj5ydG1X00OILYsn69");

const options = {
  mode: 'payment',
  amount: 1099,
  currency: 'usd',
};

// Set up Stripe.js and Elements to use in checkout form
const appearance = {
  theme: 'stripe',
  variables: {
    borderRadius: '36px',
  }
}
const expressCheckoutOptions = {
  buttonHeight: 40,
  buttonTheme: {
    applePay: 'white-outline'
  }
}
const elements = stripe.elements({
  mode: 'payment',
  amount: 1099,
  currency: 'usd',
  appearance,
})
const expressCheckoutElement = elements.create(
  'expressCheckout',
  expressCheckoutOptions
)
expressCheckoutElement.mount('#express-checkout-element')

const handleError = (error) => {
  const messageContainer = document.querySelector('#error-message');
  messageContainer.textContent = error.message;
}

expressCheckoutElement.on('confirm', async (event) => {
  const {error: submitError} = await elements.submit();
  if (submitError) {
    handleError(submitError);
    return;
  }

  // Create the PaymentIntent and obtain clientSecret
  const res = await fetch('/express-create-intent', {
    method: 'POST',
  });
  const {client_secret: clientSecret} = await res.json();

  const {error} = await stripe.confirmPayment({
    // `elements` instance used to create the Express Checkout Element
    elements,
    // `clientSecret` from the created PaymentIntent
    clientSecret,
    confirmParams: {
      return_url: "http://localhost:3000/web-elements-success",
    },
  });

  if (error) {
    // This point is only reached if there's an immediate error when
    // confirming the payment. Show the error to your customer (for example, payment details incomplete)
    handleError(error);
  } else {
    // The payment UI automatically closes with a success animation.
    // Your customer is redirected to your `return_url`.
  }
});

