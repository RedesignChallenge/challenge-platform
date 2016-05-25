class AddCommentCountsToEntities < ActiveRecord::Migration
  def change
    add_column :experiences, :comments_count, :integer, nil: false, default: 0
    add_column :ideas, :comments_count, :integer, nil: false, default: 0
    add_column :approaches, :comments_count, :integer, nil: false, default: 0
    add_column :solutions, :comments_count, :integer, nil: false, default: 0
  end
end
