class Release < ApplicationRecord
  has_many :release_review

  has_many :favorites
  has_many :ownerships
  has_many :listings
end
