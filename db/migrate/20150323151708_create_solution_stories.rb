class CreateSolutionStories < ActiveRecord::Migration
  def change
    create_table :solution_stories do |t|
      t.string :title
      t.text :description
      t.text :link
      t.text :embed
      t.string :image
      t.datetime :destroyed_at
      t.references :solution_stage

      t.timestamps
    end
  end
end
