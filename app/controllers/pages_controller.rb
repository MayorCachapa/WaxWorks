class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def index
    @user_listings = current_user.listings
    @releases = Release.all
  end
end
