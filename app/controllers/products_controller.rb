class ProductsController < ApplicationController
  before_action :set_product, only: %i[ edit update destroy ]

  def index
    @products = StripeService::Product.list_products
  end

  def show
    @product = StripeService::Product.set_product(params[:id])
    @price = StripeService::Product.price(@product.default_price)
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        product_stripe_id = StripeService::Product.create_product(@product.name, params[:product][:price])
        @product.update!(product_stripe_id:)

        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
    end
  end

  private

  def set_product
    @product = Product.find_by(product_stripe_id: params[:id])
  end

  def product_params
    params.require(:product).permit(:name)
  end
end
