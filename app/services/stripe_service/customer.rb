module StripeService
  class Customer
    def initialize(customer)
      @customer = customer
    end

    def create_customer
      Stripe.api_key = Rails.application.credentials.stripe.secret_key

      stripe_customer = Stripe::Customer.create({ name: @customer.name, email: @customer.email})

      stripe_customer.id
    end

    def self.list_payment_methods(customer_stripe_id)
      
      Stripe.api_key = Rails.application.credentials.stripe.secret_key

      Stripe::Customer.list_payment_methods(customer_stripe_id, {limit: 5})
    end
  end
end