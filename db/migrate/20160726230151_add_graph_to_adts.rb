class AddGraphToAdts < ActiveRecord::Migration
  def change
    add_reference :adts, :graph, index: true, foreign_key: true
  end
end
