class Cart < ActiveRecord::Base
  #Asociaciones
  belongs_to :user
  has_many :cart_books, dependent: :destroy
  
  def add_product(book_id)
    current_item = cart_books.find_by_book_id(book_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_books.build(book: book_id)
    end
    current_item
  end
  
  def books
    books = []
    cart_books.each {|cb| books << cb.book}
    books
  end
end
