class CreatePurchaseBooks < ActiveRecord::Migration
  def change
    create_table :purchase_books do |t|
      t.integer :book_id
      t.integer :purchase_id

      t.integer :quantity
      t.timestamps
    end
  end
end
