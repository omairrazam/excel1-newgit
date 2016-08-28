class Graph < ActiveRecord::Base
	validate :verify_cols_exist
	
	belongs_to   :category
	has_many     :adts#, :dependent => :nullify
	has_many     :graph_datums#, :dependent => :nullify
	#after_create :update_data_csv

	def update_data_csv
	    data     = CSV.read(Rails.root.to_s +  "/excelsheet/actual.csv")
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

	def verify_cols_exist
		data     = CSV.read(Rails.root.to_s +  "/excelsheet/actual.csv")
	   	header   = data[0]
	   	
	    if y2_colname.present? and !header.include?(y2_colname)
	    	errors.add(:y2_colname, "doesn't exist")
	    elsif !header.include?(y1_colname)
	    	errors.add(:y1_colname, "doesn't exist")
	    elsif !header.include?(x_colname) 
	    	errors.add(:x_colname, "doesn't exist")
	    end
	end
	
end
