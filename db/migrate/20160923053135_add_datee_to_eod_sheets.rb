class AddDateeToEodSheets < ActiveRecord::Migration
  def change
    add_column :eod_sheets, :datee, :string
  end
end
