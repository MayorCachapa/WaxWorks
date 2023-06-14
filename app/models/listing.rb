class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :release
  has_many :orders
  has_one_attached :photo

  monetize :price_cents

  validates :condition, :sleeve_condition, inclusion: {in: %w(Excellent Good Fair Damaged) }
  validates :condition, :sleeve_condition, :price_cents, :shipping_fee, :comments, :location, presence: true
  validates :price_cents, :shipping_fee, numericality: { greater_than: 0.0 }
  # before_save :convert_to_cents

  scope :available, -> { where(availability: true) }

  # private
  # def convert_to_cents
  #   self.price_cents = (price_cents * 100).to_i if price_cents.present?
  # end
end
