class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :listings
  has_many :favorites
  has_many :ownerships
  has_many :release_reviews
  has_many :orders
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:spotify]
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name
      user.avatar_url = auth.info.image
      user.spotify_token = auth.credentials.token
      user.spotify_refresh_token = auth.credentials.refresh_token
      user.spotify_token_expires_at = Time.at(auth.credentials.expires_at)
    end
  end
  validates :full_name, presence: true

  def fetch_token
    refresh_spotify_token!
  end

  def fetch_items
    fetch_user_spotify_items!
  end

  private

  def refresh_spotify_token!
    auth_params = {
      grant_type: 'refresh_token',
      refresh_token: spotify_refresh_token,
      client_id: Rails.application.credentials.dig(:spotify_client_id), 
      client_secret: Rails.application.credentials.dig(:spotify_client_secret)
    }

    response = HTTParty.post('https://accounts.spotify.com/api/token', body: auth_params)
    return unless response.code == 200

    auth_data = JSON.parse(response.body)
    self.spotify_token = auth_data['access_token']
    self.spotify_token_expires_at = Time.now + auth_data['expires_in'].seconds
    save
  end

  def fetch_user_spotify_items!
    access_token = self.spotify_token
    response_artists = HTTParty.get('https://api.spotify.com/v1/me/top/artists', headers: {
      'Authorization' => "Bearer #{access_token}"
    })
    response_tracks = HTTParty.get('https://api.spotify.com/v1/me/top/tracks', headers: {
      'Authorization' => "Bearer #{access_token}"
    })
    response_albums = HTTParty.get('https://api.spotify.com/v1/me/albums', headers: {
      'Authorization' => "Bearer #{access_token}"
    })
    
    self.top_artists = []
    if response_artists.code == 200
      results = response_artists['items']
      for item in results
        self.top_artists.append(item["name"])
      end
    else
      self.top_artists = nil
    end

    self.top_albums = []
    if response_tracks.code == 200
      results = response_tracks['items']
      for item in results
        self.top_albums.append(item["album"]['name']) unless self.top_albums.include?(item["album"]['name'])
      end
    else
      self.top_albums = nil
    end

    
    self.saved_albums = []
    if response_albums.code == 200
      results = response_albums['items']
      for item in results
        self.saved_albums.append(item['album']['name'])
      end 
    else 
      self.saved_albums = nil 
    end
    
    save
  end
end
