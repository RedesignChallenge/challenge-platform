class UpdateModelsWithPublishedAtColumn < ActiveRecord::Migration
  def up
    add_column :experiences, :published_at, :datetime
    add_column :ideas, :published_at, :datetime
    add_column :approaches, :published_at, :datetime
    add_column :solutions, :published_at, :datetime
  end

  def down
    remove_column :experiences, :published_at, :datetime
    remove_column :ideas, :published_at, :datetime
    remove_column :approaches, :published_at, :datetime
    remove_column :solutions, :published_at, :datetime
  end
end
