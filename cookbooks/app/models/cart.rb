class Cart < ActiveRecord::Base
  #Asociaciones
  belongs_to :user
  has_many :cart_books, dependent: :destroy
  
  def add_product(book_id, cantidad)
    current_item = cart_books.find_by_book_id(book_id)
    if current_item
      current_item.quantity += cantidad
    else
      current_item = cart_books.build(book: book_id, quantity: cantidad)
    end
    current_item
  end
  
  def books
    books = []
    cart_books.each {|cb| books << cb.book}
    books
  end
end
