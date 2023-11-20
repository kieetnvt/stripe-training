class StripeController < ApplicationController

  def index
  end

  # Part 1: hosted checkout page
  # get '/checkout-hosted-page'
  def checkout_hosted_page
  end

  # get '/checkout-session'
  # follow checkout_note.rb to view some examples when create checkout session
  def checkout_session
    session = Stripe::Checkout::Session.create({
      line_items: [
        {
          price_data: {
            unit_amount: 2000,
            product_data: {name: 'T-shirt'},
            currency: 'usd',
          },
          quantity: 1,
        },
      ],
      # discounts: [{coupon: 'Q7ONJtWy'}],
      allow_promotion_codes: true,
      mode: 'payment', # one time 'payment', 'subscription' for recurring payment
      success_url: 'http://localhost:3000/success',
      cancel_url: 'http://localhost:3000/cancel',
    })


    redirect_to session.url, status: 303, allow_other_host: true
  end

  # get '/success'
  def success
  end

  # get '/cancel'
  def cancel
  end

  # Part 2: embedded checkout
  # get '/embeded-checkout'
  def embeded_checkout
    render layout: "embeded_checkout"
  end

  # post '/create-embeded-checkout-session'
  def create_embeded_checkout_session
    session = Stripe::Checkout::Session.create({
      ui_mode: 'embedded',
      line_items: [{
        # Provide the exact Price ID (e.g. pr_1234) of the product you want to sell
        price: 'price_1OC0exE2rkCMN6VCyQAXsX0n',
        quantity: 1,
      }],
      mode: 'payment',
      return_url: 'http://localhost:3000/return-embeded-checkout?session_id={CHECKOUT_SESSION_ID}',
    })

    render json: { clientSecret: session.client_secret }
  end

  def session_status
    session = Stripe::Checkout::Session.retrieve(params[:session_id])

    render json: { status: session.status, customer_email: session.customer_details.email }
  end

  # get '/return-embeded-checkout'
  def return_embeded_checkout
    render layout: false
  end

  # Part 3: web element check
  # get '/web-elements-checkout'
  def web_elements_checkout
    render layout: false
  end

  # post '/create-payment-intent'
  def create_payment_intent
    data = JSON.parse(request.body.read)

    # Create a PaymentIntent with amount and currency
    payment_intent = Stripe::PaymentIntent.create(
      amount: calculate_order_amount(data['items']),
      currency: 'usd',
      # In the latest version of the API, specifying the `automatic_payment_methods` parameter is optional because Stripe enables its functionality by default.
      automatic_payment_methods: {
        enabled: true,
      },
    )

    render json: { clientSecret: payment_intent.client_secret }
  end

  # get '/custom-form-checkout'
  def custom_form_checkout
    render layout: 'custom'
  end

  # get '/web-elements-success'
  def web_elements_success
    render layout: 'custom'
  end

  # Part 4: express checkout element
  # get '/express-checkout-element'
  def express_checkout_element
    render layout: false
  end

  # post '/express-create-intent'
  def express_create_intent
    intent = Stripe::PaymentIntent.create({
      # In the latest version of the API, specifying the `automatic_payment_methods` parameter is optional because Stripe enables its functionality by default.
      automatic_payment_methods: {enabled: true},
      amount: 1099,
      currency: 'usd',
    })

    render json: { client_secret: intent.client_secret }
  end

  # Part 3 - X: web element check
  # get '/custom-form-checkout-card-elements'
  def custom_form_checkout_card_elements
    render layout: "custom_form_checkout_card_elements"
  end

  # post '/capture'
  def capture
    result = Stripe::Charge.create({
      amount: 2000,
      currency: 'usd',
      source: params[:token],
      description: 'My First Test Charge',
    })

    render json: { status: "success", result: result }, status: :ok
  end

  private

    # Securely calculate the order amount
    def calculate_order_amount(_items)
      # Replace this constant with a calculation of the order's amount
      # Calculate the order total on the server to prevent
      # people from directly manipulating the amount on the client
      1400 # 14 $ * 100
    end
end