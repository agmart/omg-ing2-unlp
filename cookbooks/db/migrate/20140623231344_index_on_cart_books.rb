class IndexOnCartBooks < ActiveRecord::Migration
  def change
    add_index :cart_books, [:book_id, :cart_id], unique: true
  end
end
