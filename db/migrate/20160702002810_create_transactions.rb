class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.text   :notification
      t.string :status
      t.string :transaction_id
      t.datetime :purchased_at
      t.timestamps null: false
    end
  end
end
