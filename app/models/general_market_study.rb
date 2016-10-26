class GeneralMarketStudy < ActiveRecord::Base
	belongs_to :user
	has_one :friendly_url, validate: true, dependent: :destroy
end
