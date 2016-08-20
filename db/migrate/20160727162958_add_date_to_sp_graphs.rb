class AddDateToSpGraphs < ActiveRecord::Migration
  def change
    add_column :sp_graphs, :x_values, :string
  end
end
