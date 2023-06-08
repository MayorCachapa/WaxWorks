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

      session = Stripe::Checkout::Session.create({
        line_items: [{
          # Provide the exact Price ID (e.g. pr_1234) of the product you want to sell
          price: 'price_1NGkDDI65PyGesk2B8kxPQoZ',
          quantity: 1,
        }],
        mode: 'payment',
        success_url: order_url(@order),
        cancel_url: order_url(@order)
      })


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
