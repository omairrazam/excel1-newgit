class CreateGeneralMarketStudies < ActiveRecord::Migration
  def change
    create_table :general_market_studies do |t|
      t.string :title
      t.text :content

      t.timestamps null: false
    end
  end
end
