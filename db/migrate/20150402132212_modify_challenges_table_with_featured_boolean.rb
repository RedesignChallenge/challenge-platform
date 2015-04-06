class ModifyChallengesTableWithFeaturedBoolean < ActiveRecord::Migration
  def up
    add_column :challenges, :featured, :boolean
    remove_column :challenges, :active
    remove_column :challenges, :public
  end

  def down
    remove_column :challenges, :featured
    add_column :challenges, :active, :boolean
    add_column :challenges, :public, :boolean
  end
end
