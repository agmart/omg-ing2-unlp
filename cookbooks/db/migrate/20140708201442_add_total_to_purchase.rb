class AddTotalToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :total, :integer, :default => 0
  end
end
