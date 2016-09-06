class Graph < ActiveRecord::Base
	belongs_to   :category
	has_many     :adts#, :dependent => :nullify
	has_many     :graph_datums#, :dependent => :nullify
	

	def update_data_csv
	    data     = CSV.read(Rails.root.to_s +  "/excelsheet/category_#{self.category.id}.csv")
	   	datums   = []
	   	header   = data[0]

	    (1..data.count).each do |i| 
	        if data[i].blank?
	    		next
	    	end

	        row = Hash[[header, data[i]].transpose]
	       
			if row[y1_colname].blank? and row[y2_colname].blank?
				next
			end

			date  = row[x_colname].to_s
			datee = date[0..3] + '-' + date[4..5] + '-' + date[6..7]
			datee = datee.to_datetime.strftime('%s').to_i * 1000

			
			d = GraphDatum.new

			d.x_values    = date
			d.y1_values   = row[y1_colname].to_f.round(8)

			if self.y2_colname.present?
			  d.y2_values  = row[y2_colname].to_f.round(8)
			  if d.y2_values == nil
			  	next
			  end
			end

			d.graph_id     = self.id
			d.timestamp_ms = datee

			datums << d
		end
	    GraphDatum.import datums
	end

	
end
