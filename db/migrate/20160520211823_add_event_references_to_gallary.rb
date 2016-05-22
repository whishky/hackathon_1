class AddEventReferencesToGallary < ActiveRecord::Migration
  def change
    add_reference :gallaries, :event, index: true, foreign_key: true
  end
end
