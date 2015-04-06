class ActsAsCommentableWithThreadingMigration < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.text :body
      t.integer :user_id, null: false
      t.integer :parent_id, :lft, :rgt
      t.boolean :reported, default: false, null: false
      t.text :video_url
      t.text :photo_url
      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, [:commentable_id, :commentable_type]
  end

  def down
    drop_table :comments
  end
end
