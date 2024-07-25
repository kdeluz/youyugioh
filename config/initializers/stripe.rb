Rails.configuration.stripe = {
  publishable_key: ENV['pk_test_51PgSQzRxBg2G8ZP2lbPsFBcvMtNqrFwWhKTo1gaxjc9GlylYHGsSLqYAIrdoUdwNgu9DoNNRMBrX33pxkPlQxsWx00gVAUeg4k'],
  currency: 'cad',
  secret_key: ENV['']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]