json.array!(@tags) do |tag|
  json.extract! tag, :id, :nombre
  json.url tag_url(tag, format: :json)
end
