class CreateJoinTables < ActiveRecord::Migration
  def change
    create_table :purchase_book, :id => false do |t|
      t.references :purchase, :null => false
      t.references :book, :null => false
    end

    create_table :cart_book, :id => false do |t|
      t.references :cart, :null => false
      t.references :book, :null => false
    end

    create_table :tag_book, :id => false do |t|
      t.references :tag, :null => false
      t.references :book, :null => false
    end
  end
end
