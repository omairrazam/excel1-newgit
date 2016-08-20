class CreateAdts < ActiveRecord::Migration
  def change
    create_table :adts do |t|

      t.timestamps null: false
    end
  end
end
