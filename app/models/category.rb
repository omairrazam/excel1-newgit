class Category < ActiveRecord::Base
	has_many :graphs#, :dependent => :destroy
	has_many  :sp_graphs#, :dependent => :destroy
	after_create :fetch_sp_graph
	accepts_nested_attributes_for :graphs, reject_if: :all_blank, allow_destroy: true


	def fetch_sp_graph
		xls     = Roo::Spreadsheet.open(Rails.root.to_s +  "/excelsheet/actual.xlsm")
		#debugger
		current_sheet = xls.sheet(sheetname)
		
		SpGraph.transaction do
		    header = current_sheet.row(5)
			((current_sheet.first_row + 5)..current_sheet.last_row).each do |i|

			row = Hash[[header, current_sheet.row(i)].transpose]
				d 			  = SpGraph.new
				date 		  = row[sp_x_colname].to_s
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
				d.save!
			end
		end
	end
end
