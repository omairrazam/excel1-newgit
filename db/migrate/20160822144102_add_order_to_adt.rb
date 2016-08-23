class AddOrderToAdt < ActiveRecord::Migration
  def change
    add_column :adts, :order_num, :integer
  end
end
