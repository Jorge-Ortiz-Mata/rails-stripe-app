class PaymentMethodForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations::Callbacks

  attribute :stripe_customer_id,        :string
  attribute :type,                      :string
  attribute :number,                    :string
  attribute :exp_month,                 :integer
  attribute :exp_year,                  :integer
  attribute :cvc,                       :string

  validates :stripe_customer_id, :type, :number, :exp_month, :exp_year, :cvc, presence: true

  def save
    return false if invalid?

    initialize_payment_method

    true
  end

  private 

  def initialize_payment_method
    stripe_payment_method = StripeService::PaymentMethod.new({stripe_customer_id:, type:, number:, exp_month:, exp_year:, cvc:})
    stripe_payment_method_id = stripe_payment_method.create_payment_method()
    stripe_payment_method.associate_payment_method_with_customer(stripe_payment_method_id)
  end
end
