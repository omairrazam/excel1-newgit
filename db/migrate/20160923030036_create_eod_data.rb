class CreateEodData < ActiveRecord::Migration
  def change
    create_table :eod_data do |t|
      t.string :txt
      t.float :value
      t.datetime :datee

      t.timestamps null: false
    end
  end
end
