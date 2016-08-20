class CreateGraphData < ActiveRecord::Migration
  def change
    create_table :graph_data do |t|
      t.string :x_values
      t.string :y1_values
      t.string :y2_values
      t.references :graph, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
