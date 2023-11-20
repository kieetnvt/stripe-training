# simple one-time payment
session = session = Stripe::Checkout::Session.create({
      # submit_type: 'donate', # submit_type: must be one of auto, pay, book, or donate
      line_items: [{
        # Provide the exact Price ID (e.g. pr_1234) of the product you want to sell
        price: 'price_1OC0exE2rkCMN6VCyQAXsX0n', # one-time
        quantity: 1,
        adjustable_quantity: {
          enabled: true,
          minimum: 1,
          maximum: 10,
        },
      }],
      locale: 'en',
      mode: 'payment', # one time 'payment', 'subscription' for recurring payment
      success_url: 'http://localhost:3000/success',
      cancel_url: 'http://localhost:3000/cancel',
      custom_fields: [
        {
          key: 'hello',
          label: {
            type: 'custom',
            custom: 'Xin chào ae nha!',
          },
          type: 'text',
        },
      ],
    })

# no cost orders
session = Stripe::Checkout::Session.create({
      line_items: [
        {
          price_data: {
            unit_amount: 0,
            product_data: {name: 'Free MacBook Pro'},
            currency: 'usd',
          },
          quantity: 1,
        },
      ],
      allow_promotion_codes: true,
      locale: 'en',
      mode: 'payment', # one time 'payment', 'subscription' for recurring payment
      success_url: 'http://localhost:3000/success',
      cancel_url: 'http://localhost:3000/cancel',
    })

# discount
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
      discounts: [{coupon: 'Q7ONJtWy'}],
      # allow_promotion_codes: true,
      mode: 'payment', # one time 'payment', 'subscription' for recurring payment
      success_url: 'http://localhost:3000/success',
      cancel_url: 'http://localhost:3000/cancel',
    })

# subscription
session = Stripe::Checkout::Session.create({
      line_items: [{
        price: 'price_1OCOexE2rkCMN6VC021Umgi5', # subs
        quantity: 1,
      }],
      mode: 'subscription', # one time 'payment', 'subscription' for recurring payment
      success_url: 'http://localhost:3000/success',
      cancel_url: 'http://localhost:3000/cancel',
    })

# subscription trials
session = Stripe::Checkout::Session.create({
      line_items: [{
        price: 'price_1OCOexE2rkCMN6VC021Umgi5', # subs
        quantity: 1,
      }],
      mode: 'subscription', # one time 'payment', 'subscription' for recurring payment
      subscription_data: {
        trial_settings: { end_behavior: { missing_payment_method: 'cancel' } },
        trial_period_days: 30,
      }, # trials
      success_url: 'http://localhost:3000/success',
      cancel_url: 'http://localhost:3000/cancel',
    })







