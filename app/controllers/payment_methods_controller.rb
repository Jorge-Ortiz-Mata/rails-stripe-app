class PaymentMethodsController < ApplicationController
  before_action :set_customer

  def destroy
    StripeService::PaymentMethod.delete_payment_method(params[:id])

    redirect_to customer_path(@customer), notice: 'El método de pago ha sido eliminado satisfactoriamente'
  end

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end
end
