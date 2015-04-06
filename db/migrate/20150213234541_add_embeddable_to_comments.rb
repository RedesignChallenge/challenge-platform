class AddEmbeddableToComments < ActiveRecord::Migration
  def change
    add_column :comments, :embed, :text
  end
end
