class GeneralMarketStudy < ActiveRecord::Base
	belongs_to :user
	extend FriendlyId
	
	friendly_id :title, use: [:slugged, :finders]

	def should_generate_new_friendly_id?
	  title_changed?
	end
end
