class AddImpactAndImplementationToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :impact, :text
    add_column :ideas, :implementation, :text
  end
end
