class OwnershipsController < ApplicationController
  def index
    user = current_user
    user.fetch_token
    user.fetch_items    
    @listings = Listing.all
  end

  def new
  end

  def create
  end
end
