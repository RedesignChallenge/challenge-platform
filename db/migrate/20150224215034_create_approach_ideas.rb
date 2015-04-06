class CreateApproachIdeas < ActiveRecord::Migration
  def change
    create_table :approach_ideas do |t|
      t.string :title
      t.text :description
      t.references :approach_stage
      t.references :idea
      t.timestamps
    end
  end
end
