class EodSheet < ActiveRecord::Base
	mount_uploader :filename, EodsheetUploader
	belongs_to     :category
	validates      :datee, uniqueness: true, presence: true
	validates	   :filename, presence: true
	after_save     :load_eod_data
	after_destroy  :remove_eod_datums

	def load_eod_data
		self.category.load_eod_data(self.datee)
	end

	def remove_eod_datums
		self.category.remove_eod_datums(self.datee)
	end
end
