class CreateSpGraphs < ActiveRecord::Migration
  def change
    create_table :sp_graphs do |t|
      t.float :open
      t.float :high
      t.float :low
      t.float :close
      t.bigint :timestamp_ms
      t.integer :category_id, index: true

      t.timestamps null: false
    end
  end
end
