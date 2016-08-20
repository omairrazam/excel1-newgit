class AddTimestampToGraphDatum < ActiveRecord::Migration
  def change
    add_column :graph_data, :timestamp_ms, :bigint
  end
end
