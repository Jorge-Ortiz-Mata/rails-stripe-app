module StripeService
  class Customer
    def initialize(customer)
      @customer = customer
      @public_key = Rails.application.credentials.stripe.public_key
      @secret_key = Rails.application.credentials.stripe.secret_key
    end

    def create_customer
      Stripe.api_key = @secret_key

      stripe_customer = Stripe::Customer.create({ name: @customer.name, email: @customer.email})

      stripe_customer.id
    end
  end
end