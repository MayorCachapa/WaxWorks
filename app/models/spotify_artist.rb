class SpotifyArtist < ApplicationRecord
    has_many :spotify_albums
    has_many :spotify_tracks
end
