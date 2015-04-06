class AddHeadlineToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :headline, :string
  end
end
