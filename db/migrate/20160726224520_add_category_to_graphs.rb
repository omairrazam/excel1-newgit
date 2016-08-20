class AddCategoryToGraphs < ActiveRecord::Migration
  def change
    add_reference :graphs, :category, index: true, foreign_key: true
  end
end
