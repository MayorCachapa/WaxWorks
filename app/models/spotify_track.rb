class SpotifyTrack < ApplicationRecord
  belongs_to :spotify_album
  belongs_to :spotify_artist

  has_many :spotify_playlists
end
