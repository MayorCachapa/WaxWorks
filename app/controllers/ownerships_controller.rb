class OwnershipsController < ApplicationController
  def index
    @listings = Listing.where(user: current_user)
    @ownerships = Ownership.where(user: current_user)   
  end

  def new
    @ownership = Ownership.new
  end

  def create
    @ownership = Ownership.new
    @ownership.user = current_user
    @ownership.release = Release.find(params[:release_id])

    if @ownership.save
      redirect_to release_path(@ownership.release)
    else
      redirect_to release_path(@ownership.release), status: :unprocessable_unit
    end
  end

  def destroy
    @ownership = Ownership.find(params[:id])
    if @ownership.user == current_user
      @ownership.destroy
    else
      redirect_to release_path(@ownership.release)
    end
  end
end
