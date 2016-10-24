class AddCategoryToGeneralMarketStudy < ActiveRecord::Migration
  def change
    add_column :general_market_studies, :category, :string
  end
end
