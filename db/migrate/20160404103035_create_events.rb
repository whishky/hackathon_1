class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :start_date
      t.string :end_date
      t.string :start_time
      t.string :end_time
      t.string :city
      t.string :address
      t.string :event_creater

      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :events, [:user_id, :created_at]
  end
end
