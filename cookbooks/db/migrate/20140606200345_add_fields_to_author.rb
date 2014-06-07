class AddFieldsToAuthor < ActiveRecord::Migration
  def change
    add_column :authors, :dni, :integer
  end
end
