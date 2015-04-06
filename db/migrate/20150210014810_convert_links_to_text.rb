class ConvertLinksToText < ActiveRecord::Migration
  def change
    change_column :experiences, :link, :text, limit: 2047
  end
end
