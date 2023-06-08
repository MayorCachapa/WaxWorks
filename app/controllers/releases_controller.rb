require 'httparty'

class ReleasesController < ApplicationController
  before_action :set_release, only: [:show]

  def index
    @releases = Release.all
    @listings = Listing.all

    if params[:query].present?
      sql = 'title ILIKE :query or artist ILIKE :query'
      @releases = @releases.where(sql, query: "%#{params[:query]}%")
    end
  end

  def new
    @release = Release.new
  end

  def create
    # raise
    response = HTTParty.get("https://api.discogs.com/database/search?q=#{params[:release][:title]}&token=#{ENV['DISCOG_TOKEN']}")
    data = JSON.parse(response.body)

    if data['results'].any?
      result = data['results'].first['title'].split(' - ')
      url = data['results'].first['cover_image']
      artist = result[0].strip
      title = result[1].strip

      @release = Release.find_by(artist: artist, title: title)
      if @release
        redirect_to new_release_listing_path(@release)
      else
        @release = Release.new(artist: artist, title: title, url: url)
        if @release.save
          redirect_to new_release_listing_path(@release)
        else
          render :new, status: :unprocessable_entity
        end
      end

    end
  end

  def show
      @listing = Listing.new
  end

  private

  def set_release
    @release = Release.find(params[:id])
  end

  def release_params
      params.require(:release).permit(:title)
  end
end
