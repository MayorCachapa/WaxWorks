class RemoveReleaseReviewFromReleases < ActiveRecord::Migration[7.0]
  def change
    remove_reference :releases, :release_review, null: false, foreign_key: true
  end
end
