class Release < ApplicationRecord
  has_many :release_reviews

  has_many :favorites
  has_many :ownerships
  has_many :listings

  validates :title, :artist, :tracklist, :date, :format, :url, :description, presence: true

  def average_listing
    if listings.empty?
      "N/A"
    else
      (listings.map(&:price).sum/listings.count)*100
    end
  end
  # private

  # def discog_validation

  # end
end
