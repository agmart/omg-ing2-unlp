class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nombre
      t.integer :dni
      t.date :fecha_alta
      t.string :direccion
      t.string :tel
      t.date :fecha_nac

      t.timestamps
    end
  end
end
