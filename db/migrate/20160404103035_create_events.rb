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

      t.timestamps null: false
    end
  end
end
