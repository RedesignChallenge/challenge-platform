class AddBooleansToUsers < ActiveRecord::Migration
  def change
    add_column :users, :video_access, :boolean, default: false
  end
end
