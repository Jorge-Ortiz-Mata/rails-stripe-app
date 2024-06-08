class Customer < ApplicationRecord
  validates :email, :name, presence: true

  after_create :create_stripe_customer

  has_many :payment_methods

  private

  def create_stripe_customer
    stripe_customer = StripeService::Customer.new(self)
    customer_stripe_id = stripe_customer.create_customer
    self.update(customer_stripe_id:)
  end
end
