class Excelsheet < ActiveRecord::Base
	mount_uploader :filename, ExcelsheetUploader

	belongs_to   :category

end
