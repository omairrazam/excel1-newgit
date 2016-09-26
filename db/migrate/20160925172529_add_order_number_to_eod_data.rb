class AddOrderNumberToEodData < ActiveRecord::Migration
  def change
    add_column :eod_data, :order_number, :integer
  end
end
