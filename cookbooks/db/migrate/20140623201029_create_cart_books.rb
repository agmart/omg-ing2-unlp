class CreateCartBooks < ActiveRecord::Migration
  def change
    create_table :cart_books do |t|
      t.integer :book_id
      t.integer :cart_id
      t.integer :quantity, default: 1
      t.timestamps
    end
  end
end
