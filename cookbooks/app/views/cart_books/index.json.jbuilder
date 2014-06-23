json.array!(@cart_books) do |cart_book|
  json.extract! cart_book, :id, :book_id, :cart_id
  json.url cart_book_url(cart_book, format: :json)
end
