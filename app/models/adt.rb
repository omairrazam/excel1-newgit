class Adt < ActiveRecord::Base
	belongs_to :graph
	has_many :adt_datums

	def update_data
		xls     = Roo::Spreadsheet.open(Rails.root.to_s +  "/excelsheet/actual.xlsm")
		current_sheet = xls.sheet(sheetname) rescue nil
		
		if current_sheet == nil
			return -1
		end

		AdtDatum.transaction do
		    header = current_sheet.row(5)
			((current_sheet.first_row + 5)..current_sheet.last_row).each do |i|
				#debugger
				row = Hash[[header, current_sheet.row(i)].transpose]

				if row[y_colname].blank? 
					next
				end

				date  = row[x_colname].to_s
				datee = date[0..3] + '-' + date[4..5] + '-' + date[6..7]
				datee = datee.to_datetime.strftime('%s').to_i * 1000

				
				d = self.adt_datums.find_or_initialize_by(timestamp_ms: datee)

				d.x_values    = date
				d.y1_values   = row[y_colname].to_f.round(8)

				
				
				d.adt_id    = self.id
				
				d.timestamp_ms = datee
				d.save!
			end
		end
		return 0

	end

end
