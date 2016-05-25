class AddIndexesOnForeignKeys < ActiveRecord::Migration
  def change
    # Inspired by: 
    # https://tomafro.net/2009/09/quickly-list-missing-foreign-key-indexes
    # Output below
    #
    # districts: state_id
    # districts_users: district_id, user_id
    # schools: lea_id, school_id, sea_school_id, district_id
    # schools_users: school_id, user_id
    # states_users: state_id, user_id
    # users: referrer_id
    # themes: experience_stage_id
    # experience_stages: challenge_id
    # experiences: user_id, theme_id
    # panels: challenge_id
    # problem_statements: idea_stage_id
    # idea_stages: challenge_id
    # ideas: problem_statement_id, user_id, refinement_parent_id
    # steps: steppable_id
    # comments: parent_id, temporal_parent_id
    # cookbooks: recipe_stage_id
    # recipes: cookbook_id, user_id, refinement_parent_id
    # solution_stories: solution_stage_id
    # suggestions: user_id
    # solution_stages: challenge_id
    # solutions: solution_story_id, user_id
    # features: user_id
    # recipe_stages: challenge_id

    add_index :users, :referrer_id
    add_index :states_users,    [:state_id,    :user_id]
    add_index :districts_users, [:district_id, :user_id]
    add_index :schools_users,   [:school_id,   :user_id]

    add_index :panels, :challenge_id, unique: true

    add_index :suggestions, :user_id
    add_index :features, :user_id
    add_index :features, [:featureable_type, :featureable_id]

    add_index :comments, [:commentable_type, :commentable_id]
    add_index :comments, :parent_id
    
    add_index :steps,    [:steppable_type, :steppable_id]

    add_index :experience_stages, :challenge_id
    add_index :themes, :experience_stage_id
    add_index :experiences, [:theme_id, :user_id]
    
    add_index :idea_stages, :challenge_id
    add_index :problem_statements, :idea_stage_id
    add_index :ideas, [:problem_statement_id, :user_id]
    add_index :ideas, :refinement_parent_id

    add_index :recipe_stages, :challenge_id
    add_index :cookbooks, :recipe_stage_id
    add_index :recipes, [:cookbook_id, :user_id]

    add_index :solution_stages, :challenge_id
    add_index :solution_stories, :solution_stage_id
    add_index :solutions, [:solution_story_id, :user_id]
  end
end
