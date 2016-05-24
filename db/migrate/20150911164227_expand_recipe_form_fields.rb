class ExpandRecipeFormFields < ActiveRecord::Migration
  def change
    add_column :recipes, :community, :text
    add_column :recipes, :conditions, :text
    add_column :recipes, :evidence, :text
    add_column :recipes, :protips, :text
    rename_column :recipes, :needs, :materials

    add_column :recipe_stages, :title_instructions, :text, default: "Add a Title"
    add_column :recipe_stages, :description_instructions, :text, default: "Describe your recipe. What are the goals? What are the challenges? Why does this recipe matter?"
    add_column :recipe_stages, :steps_instructions, :text, default: "Outline how to implement this recipe step by step."
    add_column :recipe_stages, :materials_instructions, :text, default: "What equipment or supplies are needed?"
    add_column :recipe_stages, :community_instructions, :text, default: "Every good recipe provides the number of servings. How many people need to participate and who are they?"
    add_column :recipe_stages, :conditions_instructions, :text, default: "What needs to be true of the culture or environment to try out this recipe?"
    add_column :recipe_stages, :evidence_instructions, :text, default: "What evidence can we collect to know when we’re on the right track?"
    add_column :recipe_stages, :protips_instructions, :text, default: "What advice can you offer to make the experience of trying out your recipe as smooth as possible?  Is there anything you can identify as a possible stumbling block? Things to keep in mind?"

    add_column :solutions, :community, :text
    add_column :solutions, :conditions, :text
    add_column :solutions, :evidence, :text
    add_column :solutions, :protips, :text
    rename_column :solutions, :needs, :materials
  end
end
