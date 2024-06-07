class CreatePaymentMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_methods do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :payment_method_stripe_id

      t.timestamps
    end
  end
end
