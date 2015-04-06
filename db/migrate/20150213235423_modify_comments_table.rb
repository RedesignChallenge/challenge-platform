class ModifyCommentsTable < ActiveRecord::Migration
  def change
    remove_column :comments, :video_url
    remove_column :comments, :photo_url
    add_column :comments, :link, :text
  end
end
