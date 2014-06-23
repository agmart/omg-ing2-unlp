class Delete < ActiveRecord::Migration
  def change
    drop_table :books_carts
    end
end
