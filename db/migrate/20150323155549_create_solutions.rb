class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.string :title
      t.text :description
      t.text :needs
      t.string :effort
      t.text :link
      t.text :embed
      t.string :image
      t.string :file
      t.datetime :destroyed_at
      t.references :solution_story
      t.references :user

      t.timestamps
    end
  end
end
