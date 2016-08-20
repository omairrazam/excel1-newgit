class CreateAdtData < ActiveRecord::Migration
  def change
    create_table :adt_data do |t|
      t.string :x_values
      t.string :y1_values
      t.string :y2_values
      t.references :adt, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
