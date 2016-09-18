class AddDefaultValueGraphTypeToAdts < ActiveRecord::Migration
  def change
  		adts = Adt.all.where("graph_type is null")
  		adts.each do |a|
  			a.graph_type = 'line'
  			a.save!
  		end
  end
end
