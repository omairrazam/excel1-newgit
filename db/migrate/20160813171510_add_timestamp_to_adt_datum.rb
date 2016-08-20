class AddTimestampToAdtDatum < ActiveRecord::Migration
  def change
    add_column :adt_data, :timestamp_ms, :bigint
  end
end
