class AddQuantityToBooksCarts < ActiveRecord::Migration
  def change
    add_column :books_carts, :quantity, :integer, default: 1
    add_index :books_carts, [:book_id, :cart_id], unique: true
  end
end
