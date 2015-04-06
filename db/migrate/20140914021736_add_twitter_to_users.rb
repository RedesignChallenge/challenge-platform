class AddTwitterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter, :string, limit: 15
    add_column :users, :avatar, :string
  end
end
