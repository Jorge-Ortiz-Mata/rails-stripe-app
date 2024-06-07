class Customer < ApplicationRecord
  validates :email, :name, presence: true

  after_create :create_stripe_customer

  private

  def create_stripe_customer
    stripe_customer = StripeService.new(self)
    customer_stripe_id = stripe_customer.create_customer
    self.update(customer_stripe_id:)
  end
end
