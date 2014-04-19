class AgregarIDsaModelos < ActiveRecord::Migration
  def change
    add_column :books, :author_id, :integer
    add_column :books, :editorial_id, :integer
    add_column :purchases, :user_id, :integer
    add_column :users, :cart_id, :integer
    add_index :books, :author_id
    add_index :books, :editorial_id
    add_index :purchases, :user_id
    add_index :users, :cart_id
  end
end
