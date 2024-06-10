module StripeService
  class Product
    def self.list_products
      Stripe.api_key = Rails.application.credentials.stripe.secret_key

      Stripe::Product.list({ limit: 50 })
    end


    def self.create_product(name, price)
      Stripe.api_key = Rails.application.credentials.stripe.secret_key

      product = Stripe::Product.create({
        name:,
        default_price_data: {
          currency: 'mxn',
          unit_amount_decimal: price,
        },
      })

      product.id
    end

    def self.set_product(product_id)
      Stripe.api_key = Rails.application.credentials.stripe.secret_key
      
      Stripe::Product.retrieve(product_id)
    end

    def self.price(price_id)
      Stripe.api_key = Rails.application.credentials.stripe.secret_key

      Stripe::Price.retrieve(price_id)
    end
  end
end