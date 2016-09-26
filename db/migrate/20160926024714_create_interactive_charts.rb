class CreateInteractiveCharts < ActiveRecord::Migration
  def change
    create_table :interactive_charts do |t|

      t.timestamps null: false
    end
  end
end
