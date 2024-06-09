module StripeService
  class PaymentMethod
    def initialize(params = {})
      @stripe_customer_id = params[:stripe_customer_id]
      @type = params[:type]
      @number = params[:number]
      @exp_month = params[:exp_month]
      @exp_year = params[:exp_year]
      @cvc = params[:cvc]
    end

    def create_payment_method
      Stripe.api_key = Rails.application.credentials.stripe.secret_key

      stripe_payment_method = Stripe::PaymentMethod.create({
        type: @type,
        card: {
          number: @number,
          exp_month: @exp_month,
          exp_year: @exp_year,
          cvc: @cvc,
        },
      })

      stripe_payment_method.id
    end

    def self.attach_payment_method(payment_method_id, customer_id)
      Stripe.api_key = Rails.application.credentials.stripe.secret_key

      Stripe::PaymentMethod.attach(payment_method_id, { customer: customer_id })
    end

    def self.delete_payment_method(payment_method_id)
      Stripe.api_key = Rails.application.credentials.stripe.secret_key

      Stripe::PaymentMethod.detach(payment_method_id)
    end
  end
end