class Graph < ActiveRecord::Base
	belongs_to :category
	has_many   :adts, :dependent => :destroy
	has_many   :graph_datums, :dependent => :destroy
	#after_create :update_data
	
	def update_data
		#xls     = Roo::Excelx.open(Rails.root.to_s +  "/excelsheet/actual.xlsm")
		xls     = Roo::Spreadsheet.open(Rails.root.to_s +  "/excelsheet/actual.xlsm")

		#exname = Rails.root.to_s +  "/excelsheet/actual.xlsm"
		#csvname = Rails.root.to_s +  "/excelsheet/actual.csv"
		#xls = xls.to_csv
		#xls =     Roo::CSV.new(Rails.root.to_s +  "/excelsheet/actual.csv")
		current_sheet = xls.sheet(sheetname)
		
		GraphDatum.transaction do
		    header = current_sheet.row(5)
			((current_sheet.first_row + 5)..current_sheet.last_row).each do |i|
				
				row = Hash[[header, current_sheet.row(i)].transpose]

				if row[y1_colname].blank? and row[y2_colname].blank?
					next
				end
				#debugger
				date  = row[x_colname].to_s
				datee = date[0..3] + '-' + date[4..5] + '-' + date[6..7]
				datee = datee.to_datetime.strftime('%s').to_i * 1000

				
				d = self.graph_datums.find_or_initialize_by(timestamp_ms: datee)

				d.x_values    = date
				d.y1_values   = row[y1_colname].to_f.round(8)

				
				
				if y2_colname.present?
				 d.y2_values  = row[y2_colname].to_f.round(8)
				  if d.y2_values == nil
				  	next
				  end
				end

				d.graph_id    = self.id
				#debugger
				# make x_values_timestamp in millisecond to send to graph
				
				d.timestamp_ms = datee
				d.save!
			end
		end

	end
end
