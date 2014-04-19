class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.date :fecha
      t.string :estado

      t.timestamps
    end
  end
end
