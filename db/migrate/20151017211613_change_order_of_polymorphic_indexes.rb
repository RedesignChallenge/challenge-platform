class ChangeOrderOfPolymorphicIndexes < ActiveRecord::Migration
  def change
    remove_index :features, name: 'index_features_on_featureable_type_and_featureable_id'
    remove_index :comments, name: 'index_comments_on_commentable_type_and_commentable_id'

    remove_index :steps, name: 'index_steps_on_steppable_type_and_steppable_id'
    add_index :steps, [:steppable_id, :steppable_type]

    remove_index :experiences, name: 'index_experiences_on_theme_id_and_user_id'
    add_index :experiences, [:user_id, :theme_id]

    remove_index :ideas, name: 'index_ideas_on_problem_statement_id_and_user_id'
    add_index :ideas, [:user_id, :problem_statement_id]

    remove_index :recipes, name: 'index_recipes_on_cookbook_id_and_user_id'
    add_index :recipes, [:user_id, :cookbook_id]

    remove_index :solutions, name: 'index_solutions_on_solution_story_id_and_user_id'
    add_index :solutions, [:user_id, :solution_story_id]
  end
end
