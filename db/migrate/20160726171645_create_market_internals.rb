class CreateMarketInternals < ActiveRecord::Migration
  def change
    create_table :market_internals do |t|
      t.string :title
      t.text :content

      t.timestamps null: false
    end
  end
end
