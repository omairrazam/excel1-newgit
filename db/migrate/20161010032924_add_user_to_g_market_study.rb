class AddUserToGMarketStudy < ActiveRecord::Migration
  def change
    add_column :general_market_studies, :user_id, :integer
  end
end
