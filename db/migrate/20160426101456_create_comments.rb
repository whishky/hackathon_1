class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :comments, [:event_id, :created_at]
  end
end
