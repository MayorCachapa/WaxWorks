class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :update, :destroy]

  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    @listing.release = params[:release_id]

    if @listing.save
      redirect_to listing_path(@listing)
    else
      render :show, status: :unprocessable_entity
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

  def listing_params
    params.require(:listing).permit(:condition, :sleeve_condition, :price, :shipping_fee, :comments, :location)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end
