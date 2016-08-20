class ChangeValueTypeToFloatToAdtDatums < ActiveRecord::Migration
  def change
  	remove_column :adt_data, :y1_values
  	remove_column :adt_data, :y2_values
     add_column :adt_data, :y1_values, :float
     add_column :adt_data, :y2_values, :float
  end
end
