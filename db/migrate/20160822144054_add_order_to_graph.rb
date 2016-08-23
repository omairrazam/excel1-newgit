class AddOrderToGraph < ActiveRecord::Migration
  def change
    add_column :graphs, :order_num, :integer
  end
end
