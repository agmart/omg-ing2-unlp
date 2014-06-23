class AddEnabledToBook < ActiveRecord::Migration
  def change
    add_column :books, :habilitado, :boolean, default: true
  end
end
