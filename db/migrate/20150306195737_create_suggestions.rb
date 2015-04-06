class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :title
      t.text :description
      t.text :link, limit: 2047
      t.text :embed
      t.string :image
      t.datetime :destroyed_at

      t.references :user
      t.timestamps
    end
  end
end
