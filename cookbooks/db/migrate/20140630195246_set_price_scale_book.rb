class SetPriceScaleBook < ActiveRecord::Migration
  def change
    change_column :books, :precio, :decimal, :precision => 16, :scale => 2
  end
end
