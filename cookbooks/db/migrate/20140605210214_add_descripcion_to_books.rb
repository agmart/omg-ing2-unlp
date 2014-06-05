class AddDescripcionToBooks < ActiveRecord::Migration
  def change
    add_column :books, :descripcion, :string
  end
end
