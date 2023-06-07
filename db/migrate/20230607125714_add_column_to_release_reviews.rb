class AddColumnToReleaseReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :release_reviews, :release, null: false, foreign_key: true
  end
end
