class CreateEodSheets < ActiveRecord::Migration
  def change
    create_table :eod_sheets do |t|
      t.string :filename

      t.timestamps null: false
    end
  end
end
