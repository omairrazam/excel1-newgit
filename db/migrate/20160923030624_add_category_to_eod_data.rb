class AddCategoryToEodData < ActiveRecord::Migration
  def change
    add_reference :eod_data, :category, index: true, foreign_key: true
  end
end
