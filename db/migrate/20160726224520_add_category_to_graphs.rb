class AddCategoryToGraphs < ActiveRecord::Migration
  def change
  	add_column :graphs, :category_id, :integer,index:true
   # add_reference :graphs, :category, index: true, foreign_key: true
  end
end
