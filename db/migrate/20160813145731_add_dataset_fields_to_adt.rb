class AddDatasetFieldsToAdt < ActiveRecord::Migration
  def change
  	add_column :adts, :x_colname,  :string
  	add_column :adts, :y_colname,  :string
  	add_column :adts, :sheetname,  :string
  	add_column :adts, :y_legend,   :string
  	add_column :adts, :color_y,    :string	
  end
end
