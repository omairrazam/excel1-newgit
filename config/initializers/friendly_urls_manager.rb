# # FriendlyUrls Manager contents
class RailsFriendlyUrls::Manager 
  def self.urls
    ::FriendlyUrl.all if ::FriendlyUrl.table_exists?
    #::FriendlyUrlsGms.all if ::FriendlyUrlsGms.table_exists?
  end
end
