class ReleaseReview < ApplicationRecord
  belongs_to :user
  belongs_to :release
end
