class AddCommentsCountToApproachIdea < ActiveRecord::Migration
  def change
    add_column :approach_ideas, :comments_count, :integer, nil: false, default: 0
  end
end
``