class AddColumnRatingToReleaseReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :release_reviews, :rating, :integer
  end
end
