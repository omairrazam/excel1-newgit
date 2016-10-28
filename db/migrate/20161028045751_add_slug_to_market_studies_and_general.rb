class AddSlugToMarketStudiesAndGeneral < ActiveRecord::Migration
  def change
    add_column :market_studies, :slug, :string
    add_index :market_studies, :slug, unique: true

    add_column :general_market_studies, :slug, :string
    add_index :general_market_studies, :slug, unique: true
  end
end
