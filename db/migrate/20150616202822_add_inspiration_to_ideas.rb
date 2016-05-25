class AddInspirationToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :inspiration, :boolean, default: false
  end
end
