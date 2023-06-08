class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :release

  has_many :orders

end
