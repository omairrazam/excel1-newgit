class CreateCommentaries < ActiveRecord::Migration
  def change
    create_table :commentaries do |t|
      t.string :title
      t.text :body
      t.belongs_to :user
      
      t.timestamps null: false
    end
  end
end
