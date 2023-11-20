Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ('/')
  root 'stripe#index'

  # Part 1
  get '/checkout-hosted-page', to: 'stripe#checkout_hosted_page'
  get '/checkout-session', to: 'stripe#checkout_session'
  get '/success', to: 'stripe#success'
  get '/cancel', to: 'stripe#cancel'

  # Part 2
  get '/embeded-checkout', to: 'stripe#embeded_checkout'
  post '/create-embeded-checkout-session', to: 'stripe#create_embeded_checkout_session'
  get '/return-embeded-checkout', to: 'stripe#return_embeded_checkout'
  get '/session-status', to: 'stripe#session_status'

  # Part 3
  get '/web-elements-checkout', to: 'stripe#web_elements_checkout'
  get '/custom-form-checkout', to: 'stripe#custom_form_checkout'
  post '/create-payment-intent', to: 'stripe#create_payment_intent'
  get '/web-elements-success', to: 'stripe#web_elements_success'

  # Part 3 - X
  get '/custom-form-checkout-card-elements', to: 'stripe#custom_form_checkout_card_elements'
  post '/capture', to: 'stripe#capture'

  # Part 4
  get '/express-checkout-element', to: 'stripe#express_checkout_element'
  post '/express-create-intent', to: 'stripe#express_create_intent'
end
