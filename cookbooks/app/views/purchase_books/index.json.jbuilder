json.array!(@purchase_books) do |purchase_book|
  json.extract! purchase_book, :id, :book_id, :purchase_id
  json.url purchase_book_url(purchase_book, format: :json)
end
