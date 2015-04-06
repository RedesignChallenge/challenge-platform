class AddColorForUser < ActiveRecord::Migration
  def change
    add_column :users, :color, :string
  end
end
