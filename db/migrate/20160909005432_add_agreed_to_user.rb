class AddAgreedToUser < ActiveRecord::Migration
  def change
    add_column :users, :agreed, :boolean
  end
end
