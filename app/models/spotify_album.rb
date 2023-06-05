class SpotifyAlbum < ApplicationRecord
  belongs_to :spotify_artist
  
  has_many :spotify_tracks
end
