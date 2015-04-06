class ModifyCommentsToIncludeParentIdAndSoftDelete < ActiveRecord::Migration
  def change
    add_column :comments, :temporal_parent_id, :integer
    add_column :comments, :destroyed_at, :datetime
  end
end
