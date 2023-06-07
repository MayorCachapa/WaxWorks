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
         :recoverable, :rememberable, :validatable
end
