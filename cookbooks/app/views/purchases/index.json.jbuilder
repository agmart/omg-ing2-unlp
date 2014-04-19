json.array!(@purchases) do |purchase|
  json.extract! purchase, :id, :fecha, :estado
  json.url purchase_url(purchase, format: :json)
end
