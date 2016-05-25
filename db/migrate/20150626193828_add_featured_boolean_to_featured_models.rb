class AddFeaturedBooleanToFeaturedModels < ActiveRecord::Migration
  def change
    remove_column :experiences, :top_comment, :boolean
    change_column :experiences, :featured, :boolean, default: false
    add_column :ideas, :featured, :boolean, default: false
    add_column :approaches, :featured, :boolean, default: false
    add_column :solutions, :featured, :boolean, default: false
    add_column :comments, :featured, :boolean, default: false

    remove_index :features, [:featured_id, :featured_type]
    
    rename_column :features, :featured_type, :featureable_type
    rename_column :features, :featured_id, :featureable_id

    add_index :features, [:featureable_id, :featureable_type]
  end
end
