class AddLatestCloseToEodData < ActiveRecord::Migration
  def change
    add_column :eod_data, :latest_close, :float
    add_column :eod_data, :previous_close, :float
    add_column :eod_data, :week_ago, :float
  end
end
