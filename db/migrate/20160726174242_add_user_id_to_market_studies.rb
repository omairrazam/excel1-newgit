class AddUserIdToMarketStudies < ActiveRecord::Migration
  def change
    add_column :market_studies, :user_id, :integer
  end
end
