class StripeService
  def initialize(customer)
    @customer = customer
    @public_key = Rails.application.credentials.stripe.public_key
    @secret_key = Rails.application.credentials.stripe.secret_key
  end

  def create_customer
    Stripe.api_key = @secret_key

    response = Stripe::Customer.create({ name: @customer.name, email: @customer.email})

    response.id
  end
end