class AddNewNotificationToUsers < ActiveRecord::Migration
  def change
    change_column :users, :notifications, :hstore, default: { comment_replied: true, comment_posted: true, comment_followed: true }
  end
end
