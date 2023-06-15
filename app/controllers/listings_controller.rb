class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :update, :destroy]


  def index
    @releases = Release.all
    @favorites = Favorite.all
    @favorite = Favorite.new
    @users_favorites = Favorite.where(user: current_user)
  


    @listings = Listing.all
    if params[:query].present?
      sql = 'title ILIKE :query or artist ILIKE :query'
      @releases = @releases.where(sql, query: "%#{params[:query]}%")
    end

    if params[:max].present?
      @releases = @releases.joins(:listings).where("price_cents <= ?", params[:max]).distinct
    end

    if params[:condition].present?
      @releases = @releases.joins(:listings).where(listings: {condition: params[:condition]}).distinct
    end

    if params[:sleeve_condition].present?
      @releases = @releases.joins(:listings).where(listings: {sleeve_condition: params[:sleeve_condition]}).distinct
    end

    if params[:availability].present?
      @releases = @releases.joins(:listings).where(listings: {availability: params[:availability]})
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
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update(listing_params)
      redirect_to pages_path, notice: 'Listing was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to pages_path, status: :see_other, notice: 'Listing was successfully deleted.'
  end



  private

  def listing_params
    params.require(:listing).permit(:condition, :sleeve_condition, :price_cents, :shipping_fee, :comments, :location, :photo)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end
