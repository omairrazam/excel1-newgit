json.array!(@commentaries) do |commentary|
  json.extract! commentary, :id, :title, :body, :belongs_to
  json.url commentary_url(commentary, format: :json)
end
