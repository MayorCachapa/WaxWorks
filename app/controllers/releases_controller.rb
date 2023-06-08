class ReleasesController < ApplicationController
    before_action :set_release, only: [:show]

    def index
      @releases = Release.all
      @listings = Listing.all
    end

    def show
      # //// update////

      # @album = from simple form input
      # response = HTTParty.get("https://api.discogs.com/database/search?q=#{@album}&token=#{ENV['DISCOG_TOKEN']}")
      # data = JSON.parse(response.body)
      # if data['results'].any?
      #   result = data['results'].first['title'].split('-')
      #   url = data['results'].first['cover_image']
      #   @artist = result[0].strip
      #   @title = result[1].strip
      # end

      # //// update////
      @listing = Listing.new

    end

    private
    def set_release
      @release = Release.find(params[:id])
    end
end
