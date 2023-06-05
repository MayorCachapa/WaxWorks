class UserTopSpotifyItem < ApplicationRecord
  belongs_to :spotify_track
  belongs_to :spotify_artist
  belongs_to :user
end
