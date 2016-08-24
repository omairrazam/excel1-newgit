class AddGraphToAdts < ActiveRecord::Migration
  def change
  	add_column :adts, :graph_id, :integer,index:true
    #add_reference :adts, :graph, index: true, foreign_key: true
  end
end
