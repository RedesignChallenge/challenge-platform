class AddNotificationsToUsers < ActiveRecord::Migration
  def change
    enable_extension :hstore
    add_column :users, :notifications, :hstore, default: { comment_replied: true, comment_posted: true }
  end
end
