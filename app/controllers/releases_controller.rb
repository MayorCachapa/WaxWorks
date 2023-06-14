require 'httparty'

class ReleasesController < ApplicationController
  before_action :set_release, only: [:show]

  def index
    @releases = Release.all
    @user = current_user
    @user.fetch_token
    @user.fetch_items    
    @listings = Listing.all
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
    query = "#{params[:release][:artist]} #{params[:release][:title]} #{params[:release][:date]}"
    response = HTTParty.get("https://api.discogs.com/database/search?q=#{query}&token=#{ENV['DISCOG_TOKEN']}")
    data = JSON.parse(response.body)

    current_user.fetch_token
    access_token = current_user.spotify_token
    response_search = HTTParty.get("https://api.spotify.com/v1/search?q=#{query}&type=album", headers: {
      'Authorization' => "Bearer #{access_token}"
    })
    
    albums = response_search['albums']['items']
    artists = response_search['albums']['items'].first['artists']
    
    results = data['results']

    if results.any?
      # result = results.first['title'].split(' - ')
      # result[0].downcase.include?('tool') ? artist = 'Tool' : artist = result[0]
      title = albums.first['name']
      artist = artists.first['name']

      format = results.first['format']
      format = format.nil? ? 'Unknown' : format.join(', ')

      master_id = results.first['master_id']
      response_masters = HTTParty.get("https://api.discogs.com/masters/#{master_id}")
      data_masters = JSON.parse(response_masters.body)

      release_id = data_masters['main_release']

      response_release = HTTParty.get("https://api.discogs.com/releases/#{release_id}")
      data_release = JSON.parse(response_release.body)
      description = data_release['notes']
      date = data_release['released_formatted']


      url = results.first['cover_image']


      if description.nil?
        description = "https://www.discogs.com/master/#{master_id}"
      end

      if data_masters['tracklist']
        tracklist = data_masters['tracklist']
        track_titles = tracklist.map {|track| track['title']}
      end

      @release = Release.find_by(title: title)
      if @release
        redirect_to new_release_listing_path(@release) and return
      end
    end

    @release = Release.new(
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

  def show
      @order = Order.new
      @review = ReleaseReview.new
      @reviews = ReleaseReview.where(release_id: @release)
  end

  private

  def set_release
    @release = Release.find(params[:id])
  end

  def release_params
      params.require(:release).permit(:title)
  end
end
