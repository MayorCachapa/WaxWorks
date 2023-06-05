class CreateReleases < ActiveRecord::Migration[7.0]
  def change
    create_table :releases do |t|
      t.references :release_review, null: false, foreign_key: true

      t.timestamps
    end
  end
end
