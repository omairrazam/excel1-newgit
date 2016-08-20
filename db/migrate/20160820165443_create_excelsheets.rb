class CreateExcelsheets < ActiveRecord::Migration
  def change
    create_table :excelsheets do |t|
      t.string :filename

      t.timestamps null: false
    end
  end
end
