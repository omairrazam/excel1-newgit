class FriendUrls < ActiveRecord::Migration
  def change
    create_table :friendly_urls do |t|
      t.string :path
      t.string :slug
      t.string :controller
      t.string :action
      t.string :defaults
      t.references :market_study, index: true
      t.references :general_market_study, index: true
     

      t.timestamps null: false
    end
    add_foreign_key :friendly_urls, :market_studies
    add_foreign_key :friendly_urls, :general_market_studies
    

    add_index :friendly_urls, :slug, unique: true
  end
end
