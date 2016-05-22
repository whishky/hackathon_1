class CreateGallaries < ActiveRecord::Migration
  def change
    create_table :gallaries do |t|
      t.string :image
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
