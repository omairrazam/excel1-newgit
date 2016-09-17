class AddPeriodToGraphs < ActiveRecord::Migration
  def change
    add_column :graphs, :period, :string
  end
end
