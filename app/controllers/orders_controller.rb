class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :edit, :update, :destroy]
    
    def index
      @orders = Order.all
    end
  
    def new
      @order = Order.new
    end
  
    def create
      @order = Order.new(order_params)
      @order.user = current_user
      @order.listing = Listing.find(params[:listing_id])
      
      if @order.save
        redirect_to listing_path(@order.listing)
      else
        render 'listings/show', status: :unprocessable_entity
      end
    end
  
    def show
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
