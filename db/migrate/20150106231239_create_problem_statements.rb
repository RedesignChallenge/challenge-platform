class CreateProblemStatements < ActiveRecord::Migration
  def change
    create_table :problem_statements do |t|
      t.string :title
      t.text :description
      
      t.references :ideation_stage
      t.timestamps
    end
  end
end
