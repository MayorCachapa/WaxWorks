class SpotifyTrack < ApplicationRecord
  belongs_to :spotify_album
  belongs_to :spotify_artist

  has_many :spotify_playlists
  has_many :user_top_spotify_items
end
