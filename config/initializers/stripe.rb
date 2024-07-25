Rails.configuration.stripe = {
  publishable_key: ENV['pk_test_51PgSQzRxBg2G8ZP2lbPsFBcvMtNqrFwWhKTo1gaxjc9GlylYHGsSLqYAIrdoUdwNgu9DoNNRMBrX33pxkPlQxsWx00gVAUeg4k'],
  secret_key: ENV['sk_test_51PgSQzRxBg2G8ZP2Beuh6Y7GY1ygrbVPtqBdnaKwWxU6O7axRUyR0RAkXiH4nAy69eUGPWDJqwmb2IV9FFyVhMu900R8NQpyMn']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
