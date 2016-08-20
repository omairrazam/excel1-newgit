class AddTypeAndPriceTargetToCommentaries < ActiveRecord::Migration
  def change
    add_column :commentaries, :typee, :string
    add_column :commentaries, :priceTarget, :string
  end
end
