class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :title
      t.text :description
      t.string :video_url
      t.string :image # (attached via carrierwave)
      t.string :link
      t.boolean :featured
      t.boolean :top_comment

      t.references :user
      t.references :theme
      t.timestamps
    end
  end
end
