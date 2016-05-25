class RenameRecipeIdeasToCookbooks < ActiveRecord::Migration
  def change
    rename_table :recipe_ideas, :cookbooks
    rename_column :recipes, :recipe_idea_id, :cookbook_id
    remove_column :cookbooks, :idea_id
  end
end
