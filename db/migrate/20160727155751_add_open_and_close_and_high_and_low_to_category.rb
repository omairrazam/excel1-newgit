class AddOpenAndCloseAndHighAndLowToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :open_colname,  :string
    add_column :categories, :close_colname, :string
    add_column :categories, :high_colname,  :string
    add_column :categories, :low_colname,   :string
  end
end
