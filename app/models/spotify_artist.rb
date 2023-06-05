class SpotifyArtist < ApplicationRecord
    has_many :spotify_albums
    has_many :spotify_tracks
    has_many :user_top_spotify_items
end
