class ModifyChallengesTable < ActiveRecord::Migration
  def change
    remove_column :challenges, :subtitle
    add_column :challenges, :background, :text
    add_column :challenges, :outcome, :text
    add_column :challenges, :help, :text
    add_column :challenges, :image, :string
    add_column :challenges, :active, :boolean, default: false
    add_column :challenges, :public, :boolean, default: false
    add_column :challenges, :starts_at, :datetime
    add_column :challenges, :active_stage, :string
    drop_table :questions
  end
end
