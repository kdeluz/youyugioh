Rails.configuration.stripe = {
  publishable_key: ENV['pk_test'],
  currency: 'cad',
  secret_key: ENV['sk_test']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
