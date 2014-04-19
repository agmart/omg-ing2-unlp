class CreateEditorials < ActiveRecord::Migration
  def change
    create_table :editorials do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
