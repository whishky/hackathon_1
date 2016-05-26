class CreateAvgratings < ActiveRecord::Migration
  def change
    create_table :avgratings do |t|
      t.integer :ratingsum
      t.integer :rateduser
      t.references :gallary, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
