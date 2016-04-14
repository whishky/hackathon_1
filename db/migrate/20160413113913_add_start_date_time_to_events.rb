class AddStartDateTimeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :start_date_time, :string
  end
end
