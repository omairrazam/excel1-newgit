class Adt < ActiveRecord::Base
	validate :verify_cols_exist

	belongs_to :graph
	has_many :adt_datums, :dependent => :nullify

	def update_data_csv
		
	    data = CSV.read(Rails.root.to_s +  "/excelsheet/actual.csv")
	   	adtdatums = []
	   	header    = data[0]
	   
	    (1..data.count).each do |i| 
	        if data[i].blank?
	    		next
	    	end

			row = Hash[[header, data[i]].transpose]

			if row[y_colname].blank? or row[x_colname].blank? 
				next
			end

			date  = row[x_colname].to_s
			datee = date[0..3] + '-' + date[4..5] + '-' + date[6..7]
			datee = datee.to_datetime.strftime('%s').to_i * 1000

			

			d = AdtDatum.new

			d.x_values     = date
			d.y1_values    = row[y_colname].to_f.round(8)
			d.adt_id       = self.id
			d.timestamp_ms = datee

			adtdatums << d
		end
	    AdtDatum.import adtdatums
	end

	def verify_cols_exist
		data     = CSV.read(Rails.root.to_s +  "/excelsheet/actual.csv")
	   	
	   	header   = data[0]

    	if !header.include?(x_colname)
    		errors.add(:x_colname, "doesn't exist")
	    elsif !header.include?(y_colname)
	    	errors.add(:y_colname, "doesn't exist")
	   
	end
end
