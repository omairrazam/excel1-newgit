json.array!(@interesteds) do |interested|
  json.extract! interested, :id, :content
  json.url interested_url(interested, format: :json)
end
