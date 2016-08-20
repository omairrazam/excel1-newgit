class AddColorToGraph < ActiveRecord::Migration
  def change
    add_column :graphs, :color_y1, :string
    add_column :graphs, :color_y2, :string
  end
end
