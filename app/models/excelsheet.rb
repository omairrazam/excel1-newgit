class Excelsheet < ActiveRecord::Base
	mount_uploader :filename, ExcelsheetUploader

end
