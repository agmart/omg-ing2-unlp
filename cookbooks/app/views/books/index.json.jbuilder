json.array!(@books) do |book|
  json.extract! book, :id, :isbn, :titulo, :paginas, :precio, :fecha_publicacion
  json.url book_url(book, format: :json)
end
