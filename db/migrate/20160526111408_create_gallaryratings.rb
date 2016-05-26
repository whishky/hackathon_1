class CreateGallaryratings < ActiveRecord::Migration
  def change
    create_table :gallaryratings do |t|
      t.integer :rating, :default => 0
      t.references :gallary, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
