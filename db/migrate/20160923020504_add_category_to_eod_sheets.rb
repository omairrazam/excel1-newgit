class AddCategoryToEodSheets < ActiveRecord::Migration
  def change
    add_column :eod_sheets, :category_id, :string
  end
end
