class CreateGraphs < ActiveRecord::Migration
  def change
    create_table :graphs do |t|

      t.timestamps null: false
    end
  end
end
