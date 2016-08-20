class AddTypeAndPricetargetToMarketStudies < ActiveRecord::Migration
  def change
    add_column :market_studies, :typee, :string
    add_column :market_studies, :price_target, :string
  end
end
