class RemoveStartTimeFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :start_time, :string
  end
end
