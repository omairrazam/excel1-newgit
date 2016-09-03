class AddCategoryIdToExcelsheet < ActiveRecord::Migration
  def change
    add_column :excelsheets, :category_id, :integer, index:true
  end
end
