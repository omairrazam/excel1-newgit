class ChangeColumnTypeGraphDatum < ActiveRecord::Migration
  def change
  	remove_column :graph_data, :y1_values
  	remove_column :graph_data, :y2_values
     add_column :graph_data, :y1_values, :integer
     add_column :graph_data, :y2_values, :integer
  	
  end
end
