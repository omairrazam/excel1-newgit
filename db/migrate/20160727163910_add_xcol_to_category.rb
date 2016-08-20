class AddXcolToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :sp_x_colname, :string
  end
end
