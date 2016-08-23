class AddOrderToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :order_num, :integer
  end
end
