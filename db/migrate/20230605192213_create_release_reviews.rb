class CreateReleaseReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :release_reviews do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
