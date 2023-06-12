class OwnershipsController < ApplicationController
  def index
    user = current_user
    user.refresh_spotify_token!
    access_token = user.spotify_token
    response_artists = HTTParty.get('https://api.spotify.com/v1/me/top/artists', headers: {
      'Authorization' => "Bearer #{access_token}"
    })
    response_tracks = HTTParty.get('https://api.spotify.com/v1/me/top/tracks', headers: {
      'Authorization' => "Bearer #{access_token}"
    })
    response_albums = HTTParty.get('https://api.spotify.com/v1/me/albums', headers: {
      'Authorization' => "Bearer #{access_token}"
    })
    

    @top_artists = []
    if response_artists.code == 200
      results = response_artists['items']
      for item in results
        @top_artists.append(item["name"])
      end
    else
      @top_artists = nil
    end

    @top_tracks = []
    @top_albums = []
    if response_tracks.code == 200
      results = response_tracks['items']
      for item in results
        @top_tracks.append(item['name'])
        @top_albums.append(item["album"]['name']) unless @top_tracks.include?(item["album"]['name'])
      end
    else
      @top_tracks = nil
    end

    @saved_albums = []
    if response_albums.code == 200
      results = response_albums['items']
      for item in results
        @saved_albums.append(item['album']['name'])
      end 
    else 
      @saved_albums = nil 
    end
  end

  def new
  end

  def create
  end
end
