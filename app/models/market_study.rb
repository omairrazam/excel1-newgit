class MarketStudy < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :title, use: [:slugged, :finders]
	mount_uploader :image, ImageUploader

	belongs_to :user

	def should_generate_new_friendly_id?
	  title_changed?
	end
end
