class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
