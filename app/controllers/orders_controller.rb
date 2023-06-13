class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :edit, :update, :destroy]

    def index
      @orders = current_user.orders
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

      price = Stripe::Price.create({
        unit_amount:  (listing.price_cents * 100).to_i,
        currency: 'eur',
        product_data:  {name: listing.release.title
      }})


          line_items = []

        if current_user.lastest_stripe_session_id
          line_items = Stripe::Checkout::Session.list_line_items(current_user.lastest_stripe_session_id).data
          line_items.map!{|line_item| { price:line_item.price.id, quantity: 1}}
          line_items.push({price: price.id, quantity: 1})
        else
          line_items = [{price: price.id, quantity: 1}]
        end


      session = Stripe::Checkout::Session.create({
        line_items: ,
        mode: 'payment',
        success_url: order_url(@order),
        cancel_url: order_url(@order)
      })

      current_user.update_without_password(lastest_stripe_session_id: session.id)

      @order.update(checkout_session_id: session.id)
      redirect_to orders_path
    end

    def show
      @order = current_user.orders.find(params[:id])
    end

    def edit
    end

    def update
    end

    def destroy
      @order = Order.find(params[:id])
      @order.destroy
      redirect_to orders_path, status: :see_other, notice: 'Order was successfully deleted.'
    end

    private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:shipping_address)
    end
end
