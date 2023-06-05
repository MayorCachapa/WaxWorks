class Release < ApplicationRecord
  belongs_to :release_review

  has_many :favorites
  has_many :ownerships
  has_many :listings
end
