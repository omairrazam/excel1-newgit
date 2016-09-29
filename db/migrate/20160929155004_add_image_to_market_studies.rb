class AddImageToMarketStudies < ActiveRecord::Migration
  def change
    add_column :market_studies, :image, :string
  end
end
