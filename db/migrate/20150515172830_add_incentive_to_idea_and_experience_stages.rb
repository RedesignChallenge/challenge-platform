class AddIncentiveToIdeaAndExperienceStages < ActiveRecord::Migration
  def change
    add_column :idea_stages, :incentive, :text
    add_column :experience_stages, :incentive, :text
  end
end
