class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :update, :destroy]

  def index
    @releases = Release.all

    @listings = Listing.all
    if params[:query].present?
      sql = 'title ILIKE :query or artist ILIKE :query'
      @releases = @releases.where(sql, query: "%#{params[:query]}%")
    end
  end

  def new
    @listing = Listing.new
    @release = Release.find(params[:release_id])
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    @listing.release = Release.find(params[:release_id])
    # raise
    if @listing.save
      redirect_to releases_path
    else
      render :new, status: :unprocessable_entity
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
