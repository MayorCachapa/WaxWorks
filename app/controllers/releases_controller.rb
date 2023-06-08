class ReleasesController < ApplicationController
    before_action :set_release, only: [:show]

    def index
      @releases = Release.all
      @listings = Listing.all
    end

    def new
      @release = Release.new
      @listing = Listing.new
    end

    def create
      
    end

    def show
    end

    private

    def set_release
      @release = Release.find(params[:id])
    end
end
