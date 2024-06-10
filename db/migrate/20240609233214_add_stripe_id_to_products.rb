class AddStripeIdToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :product_stripe_id, :string
  end
end
