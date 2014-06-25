class ChangeNameBookCart < ActiveRecord::Migration
  def change
    rename_table :cart_book, :books_carts
  end
end
