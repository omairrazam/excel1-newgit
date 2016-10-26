class FriendlyUrl < ActiveRecord::Base

  include RailsFriendlyUrls::FriendlyUrl

  belongs_to :market_study
  belongs_to :general_market_study

  before_create :complete_url

  after_save :reload_routes

  serialize :defaults

  validates :slug, presence: true, uniqueness: true

  def complete_url
   
    if self.market_study.present?
      self.path = "/market_studies/#{market_study.reload.id}"
    else
      self.path = "/general_market_studies/#{general_market_study.reload.id}"
    end

    set_destination_data!
  end

  def reload_routes
    RailsFriendlyUrls::Manager.apply_changes!
  end
end
