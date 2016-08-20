class AddDatasetFieldsToGraphs < ActiveRecord::Migration
  def change
  	add_column :graphs, :x_colname, :string
  	add_column :graphs, :y1_colname, :string
  	add_column :graphs, :y2_colname, :string
  	add_column :graphs, :sheetname, :string
  	add_column :graphs, :y1_legend, :string
  	add_column :graphs, :y2_legend, :string
  end
end

