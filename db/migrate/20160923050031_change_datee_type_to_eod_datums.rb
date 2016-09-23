class ChangeDateeTypeToEodDatums < ActiveRecord::Migration
  def change
  	change_column :eod_data, :datee,  :string
  end
end
