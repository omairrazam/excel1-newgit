class MarketStudy < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	#has_one :friendly_url, validate: true, dependent: :destroy

	belongs_to :user
end
