class Release < ApplicationRecord
  has_many :release_reviews

  has_many :favorites
  has_many :ownerships
  has_many :listings

  validates :title, :artist, :tracklist, :date, :format, :url, :description, presence: true
  # private

  # def discog_validation
    
  # end
end
