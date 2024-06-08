class PaymentMethodsController < ApplicationController
  before_action :set_customer
  before_action :set_payment_method, only: %i[ show edit update destroy ]

  def show; end

  def new
    @payment_method_form = PaymentMethodForm.new
  end

  def edit; end

  def create
    @payment_method_form = PaymentMethodForm.new payment_method_form_params
    @payment_method_form.stripe_customer_id = @customer.customer_stripe_id

    respond_to do |format|
      if @payment_method_form.save
        # format.html { redirect_to customer_path(@customer), notice: "Payment method was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end

  rescue Stripe::StripeError => e
    redirect_to new_customer_payment_method_path(@customer), notice: e.message
  end

  def update
    respond_to do |format|
      if @payment_method.update(payment_method_params)
        format.html { redirect_to payment_method_url(@payment_method), notice: "Payment method was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @payment_method.destroy!

    respond_to do |format|
      format.html { redirect_to payment_methods_url, notice: "Payment method was successfully destroyed." }
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def set_payment_method
    @payment_method = PaymentMethod.find(params[:id])
  end

  def payment_method_form_params
    params.require(:payment_method_form).permit(:type, :number, :exp_month, :exp_year, :cvc)
  end
end
