class ChangeIdeaLinksToText < ActiveRecord::Migration
  def change
    change_column :ideas, :link, :text, limit: 2047
  end
end
