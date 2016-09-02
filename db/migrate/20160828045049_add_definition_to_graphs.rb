class AddDefinitionToGraphs < ActiveRecord::Migration
  def change
    add_column :graphs, :definition, :text
  end
end
