class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :edit, :update, :destroy]

    def index
      @orders = Order.all
    end

    def new
      @order = Order.new
      @listing = Listing.find(params[:listing_id])
    end

    def create
      @order = Order.new()
      @order.user = current_user
      listing = Listing.find(params[:listing_id])
      @order.listing = Listing.find(params[:listing_id])
      @order.status = "pending"
      @order.final_price = listing.price

      @order.save

      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          price: {
            "id": "price_#{(0...8).map { (65 + rand(26)).chr }.join}",
            "object": "price",
            "active": true,
            "billing_scheme": "per_unit",
            "created": 1686223394,
            "currency": "usd",
            "livemode": false,

            "metadata": {},

            "product": "prod_O2mUODhyjnnJrC",
            "recurring": {

              "interval": "month",
              "interval_count": 1,
              "usage_type": "licensed"
            },
            "tax_behavior": "unspecified",


            "type": "recurring",
            "unit_amount": listing.price_cents,
            "unit_amount_decimal": "#{listing.price_cents}"
          },
          quantity: 1
        }],
        success_url: order_url(@order),
        cancel_url: order_url(@order)
      )

      @order.update(checkout_session_id: session.id)
      redirect_to new_order_payment_path(@order)
    end

    def show
      @order = current_user.orders.find(params[:id])
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:shipping_address)
    end
end
