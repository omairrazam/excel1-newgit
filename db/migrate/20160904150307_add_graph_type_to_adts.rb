class AddGraphTypeToAdts < ActiveRecord::Migration
  def change
    add_column :adts, :graph_type, :string
  end
end
