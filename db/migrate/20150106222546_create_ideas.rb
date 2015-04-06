class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.text :description
      t.string :link
      t.string :image
      t.string :file
      t.text :embed
      
      t.references :problem_statement
      t.references :user
      t.references :refinement_parent
      t.timestamps
    end
  end
end
