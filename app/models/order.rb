class Order < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  # before_save :calculate_total_price

  # private

  # def calculate_total_price
  #   self.total_price = listing.price + listing.shipping_fee
  # end
end
