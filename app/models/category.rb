class Category < ActiveRecord::Base
	#validate :verify_sheet_exists 
	#validate :verify_cols_exist , on: :fetch_sp_csv
	has_one      :excelsheet
	has_many     :graphs#, :dependent => :nullify
	has_many     :sp_graphs#, :dependent => :nullify
	#after_create :fetch_sp_csv

	accepts_nested_attributes_for :graphs, reject_if: :all_blank, allow_destroy: true

	require 'csv'
	require 'active_record'
	require "activerecord-import/base"

	def fetch_sp_csv

		if !verify_sheet_exists
			return -1
		elsif !verify_cols_exist
			return -2
		end

	    data     = CSV.read(Rails.root.to_s +  "/excelsheet/category_#{self.id}.csv")
	   	spgraphs = []
	   	header   = data[0]

	    #columns = [:open, :close, :low,:high]
	    (1..data.count).each do |i| 
	        if data[i].blank?
	    		next
	    	end

	        row = Hash[[header, data[i]].transpose]
	       
	        d 	  = SpGraph.new
			date  = row[sp_x_colname].to_s

			if date.blank?
				next
			end

			d.x_values    = date
			d.open   	  = row[open_colname]
			d.close   	  = row[close_colname]
			d.high   	  = row[high_colname]
			d.low   	  = row[low_colname]
			d.category_id = id
			
			# make x_values_timestamp in millisecond to send to graph
			datee = date[0..3] + '-' + date[4..5] + '-' + date[6..7]
			datee = datee.to_datetime.strftime('%s').to_i * 1000
			d.timestamp_ms = datee

			spgraphs << d
		end
	    #debugger
	    SpGraph.import spgraphs
	   # SpGraph.import columns, data, validate: false
  		
	end


    def verify_cols_exist
		data     = CSV.read(Rails.root.to_s +  "/excelsheet/category_#{self.id}.csv")
	   	
	   	header   = data[0]

    	if !header.include?(open_colname)
    		return false
	    elsif !header.include?(close_colname)
	    	return false
	    elsif !header.include?(high_colname)
	    	return false
	    elsif !header.include?(low_colname)
	    	return false
	    elsif !header.include?(sp_x_colname) 
	    	return false
	    else
	    	return true
	    end
	end

	def verify_sheet_exists
      if !File.exist?(Rails.root.to_s +  "/excelsheet/category_#{self.id}.csv") 
      	return false
      else 
      	return true
      end
    end
	

end



