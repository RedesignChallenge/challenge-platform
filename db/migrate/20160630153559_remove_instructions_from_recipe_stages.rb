class RemoveInstructionsFromRecipeStages < ActiveRecord::Migration
  def change
    remove_column :recipe_stages, :title_instructions
    remove_column :recipe_stages, :description_instructions 
    remove_column :recipe_stages, :steps_instructions 
    remove_column :recipe_stages, :materials_instructions 
    remove_column :recipe_stages, :community_instructions 
    remove_column :recipe_stages, :conditions_instructions 
    remove_column :recipe_stages, :evidence_instructions 
    remove_column :recipe_stages, :protips_instructions 
  end
end
