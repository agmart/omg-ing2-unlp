class AgregarRolUser < ActiveRecord::Migration
  def change
    add_column :users, :es_admin, :boolean, :default => false
  end
end
