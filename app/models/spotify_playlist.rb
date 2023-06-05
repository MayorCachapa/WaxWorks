class SpotifyPlaylist < ApplicationRecord
  belongs_to :spotify_track
  belongs_to :user
end
