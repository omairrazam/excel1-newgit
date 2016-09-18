class Adt < ActiveRecord::Base
	#validate :verify_cols_exist
	validates :name, presence: true
	validates :x_colname, presence: true
	validates :y_colname, presence: true
	validates :y_legend, presence: true
	belongs_to :graph
	has_many :adt_datums, :dependent => :nullify

	def update_data_csv
		
	    data = CSV.read(Rails.root.to_s +  "/excelsheet/category_#{self.graph.category.id}.csv")
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

		if !File.exist?(Rails.root.to_s +  "/excelsheet/category_#{self.graph.category.id}.csv") 
      		errors.add(:file, "doesn't exist")
      		return
      	end

		data     = CSV.read(Rails.root.to_s +  "/excelsheet/category_#{self.graph.category.id}.csv")
	   	
	   	header   = data[0]

    	if !header.include?(x_colname)
    		errors.add(:x_colname, "doesn't exist")
	    elsif !header.include?(y_colname)
	    	errors.add(:y_colname, "doesn't exist")
	    end 
	end

	def graph_type?
		if graph_type.blank?
			'line'
		else
			self.graph_type
		end
		
	end
end
