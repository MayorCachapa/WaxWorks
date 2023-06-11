class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :listings
  has_many :favorites
  has_many :ownerships
  has_many :release_reviews
  has_many :orders
  has_many :user_top_spotify_items
  has_many :spotify_playlists

  serialize :user_top_spotify_items, JSON
  
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
end
