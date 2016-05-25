class RenameApproachToRecipe < ActiveRecord::Migration
  def change
    remove_index "approaches", ["cached_votes_down"]
    remove_index "approaches", ["cached_votes_score"]
    remove_index "approaches", ["cached_votes_total"]
    remove_index "approaches", ["cached_votes_up"]
    remove_index "approaches", ["cached_weighted_average"]
    remove_index "approaches", ["cached_weighted_score"]
    remove_index "approaches", ["cached_weighted_total"]

    remove_index "approaches_solutions", ["approach_id"]
    remove_index "approaches_solutions", ["solution_id"]

    rename_table :approach_stages, :recipe_stages
    rename_table :approach_ideas, :recipe_ideas
    rename_table :approaches, :recipes
    rename_table :approaches_solutions, :recipes_solutions

    rename_column :recipe_ideas, :approach_stage_id, :recipe_stage_id
    rename_column :recipes, :approach_idea_id, :recipe_idea_id
    rename_column :recipes_solutions, :approach_id, :recipe_id

    add_index "recipes", ["cached_votes_down"], name: "index_recipes_on_cached_votes_down", using: :btree
    add_index "recipes", ["cached_votes_score"], name: "index_recipes_on_cached_votes_score", using: :btree
    add_index "recipes", ["cached_votes_total"], name: "index_recipes_on_cached_votes_total", using: :btree
    add_index "recipes", ["cached_votes_up"], name: "index_recipes_on_cached_votes_up", using: :btree
    add_index "recipes", ["cached_weighted_average"], name: "index_recipes_on_cached_weighted_average", using: :btree
    add_index "recipes", ["cached_weighted_score"], name: "index_recipes_on_cached_weighted_score", using: :btree
    add_index "recipes", ["cached_weighted_total"], name: "index_recipes_on_cached_weighted_total", using: :btree

    add_index "recipes_solutions", ["recipe_id"], name: "index_recipes_solutions_on_recipe_id", using: :btree
    add_index "recipes_solutions", ["solution_id"], name: "index_recipes_solutions_on_solution_id", using: :btree
  end
end
