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
    response = HTTParty.get("https://api.discogs.com/database/search?q=#{params[:release][:artist]} #{params[:release][:title]}&token=#{ENV['DISCOG_TOKEN']}")
    data = JSON.parse(response.body)
    data = JSON.parse(response.body)
    results = data['results']
  
    if results.any?
      result = results.first['title'].split(' - ')
      format = results.first['format']
      
      master_id = results.first['master_id']
  
      response_masters = HTTParty.get("https://api.discogs.com/masters/#{master_id}")
      data_masters = JSON.parse(response_masters.body)
  
      release_id = data_masters['main_release']
  
      response_release = HTTParty.get("https://api.discogs.com/releases/#{release_id}")
      data_release = JSON.parse(response_release.body)
  
      description = data_release['notes']
      date = data_release['released_formatted']
  
      if description.nil?
        description = "https://www.discogs.com/master/#{master_id}"
      end
  
      if data_masters['tracklist']
        tracklist = data_masters['tracklist']
        track_titles = tracklist.map {|track| track['title']}
        # puts track_titles
      end
  
      format = format.nil? ? 'Unknown' : format.join(', ')
  
      url = results.first['cover_image']
      artist = result[0].strip
      artist_params = params[:release][:artist]

      if artist.downcase != artist_params.downcase
        artist = artist_params.capitalize
      end
      
      if result[1].nil?
        render :new, status: :unprocessable_entity
      else
        title = result[1].strip
      end      
      
      @release = Release.find_by(artist: artist, title: title)
      if @release
        redirect_to new_release_listing_path(@release)
      else
        @release = Release.create(
          artist: artist, 
          title: title, 
          url: url, 
          format: format, 
          tracklist: track_titles, 
          description: description,
          date: date
        )
        
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
