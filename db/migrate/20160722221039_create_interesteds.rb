class CreateInteresteds < ActiveRecord::Migration
  def change
    create_table :interesteds do |t|
      t.text :content
      t.timestamps null: false
    end
  end
end
