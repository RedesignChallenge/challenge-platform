class AddSoftDestroyToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :destroyed_at, :datetime
  end
end
