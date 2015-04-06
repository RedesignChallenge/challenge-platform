class ModifyExperienceTable < ActiveRecord::Migration
  def change
    remove_column :experiences, :video_url
    add_column :experiences, :embed, :text
  end
end
