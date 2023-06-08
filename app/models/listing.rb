class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :release
  has_many :orders

  validates :condition, :sleeve_condition, inclusion: {in: %w(Excellent Good Fair Damaged) }
  validates :condition, :sleeve_condition, :price, :shipping_fee, :comments, :location, presence: true
  monetize :price_cents


end
