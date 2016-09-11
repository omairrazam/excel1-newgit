class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :code
      t.float :price

      t.timestamps null: false
    end
  end
end
