class ChangeTypeToFloatToGraphDatum < ActiveRecord::Migration
  def change
  	change_column :graph_data, :y1_values,  :float
  	change_column :graph_data, :y2_values,  :float
  end
end
