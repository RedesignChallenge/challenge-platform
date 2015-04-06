class AddDisplayNameAndAvatarOptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :display_name, :string
    add_column :users, :avatar_option, :string, default: 'twitter'
  end
end
