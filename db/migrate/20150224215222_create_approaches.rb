class CreateApproaches < ActiveRecord::Migration
  def change
    create_table :approaches do |t|
      t.string :title
      t.text :description
      t.text :needs
      t.text :link
      t.string :image
      t.text :file
      t.text :embed
      t.datetime :destroyed_at
      t.references :approach_idea
      t.references :user
      t.integer :refinement_parent_id
      t.timestamps
    end
  end
end
