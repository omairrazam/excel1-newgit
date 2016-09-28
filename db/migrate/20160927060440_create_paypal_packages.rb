class CreatePaypalPackages < ActiveRecord::Migration
  def change
    create_table :paypal_packages do |t|
      t.float :amount
      t.integer :period
      t.integer :cycles
      t.string :subscription_type

      t.timestamps null: false
    end
  end
end
