class StripeController < ApplicationController
  before_action :set_customer

  def attach_payment_method
    StripeService::PaymentMethod.attach_payment_method(params[:payment_method_id], @customer.customer_stripe_id)
  end

  private 

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end
end
