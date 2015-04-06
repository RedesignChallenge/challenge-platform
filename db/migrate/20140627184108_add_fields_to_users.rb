class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :role, :string
    add_column :users, :organization, :string
    add_column :users, :admin, :boolean, default: false
    add_column :users, :ga_dimension, :string
  end
end
