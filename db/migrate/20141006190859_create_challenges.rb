class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :title
      t.text :subtitle
      t.text :description
      t.string :hashtag
      t.string :slug
      t.string :video_url
      t.datetime :ends_at
      
      t.timestamps
    end
  end
end
