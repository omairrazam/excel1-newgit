class AddAdtNameToAdts < ActiveRecord::Migration
  def change
    add_column :adts, :name, :string
  end
end
