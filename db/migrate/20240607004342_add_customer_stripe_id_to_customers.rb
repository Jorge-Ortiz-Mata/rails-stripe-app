class AddCustomerStripeIdToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :customer_stripe_id, :string
  end
end
