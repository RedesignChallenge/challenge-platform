class RenameIdeationStageIdeaStage < ActiveRecord::Migration
  def change
    rename_table :ideation_stages, :idea_stages
    rename_column :problem_statements, :ideation_stage_id, :idea_stage_id
  end
end
