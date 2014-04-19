class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :titulo
      t.integer :paginas
      t.decimal :precio
      t.integer :año_publicacion

      t.timestamps
    end
  end
end
