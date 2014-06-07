class AgregarDireccionEditorial < ActiveRecord::Migration
  def change
    add_column :editorials, :direccion, :string
  end
end
