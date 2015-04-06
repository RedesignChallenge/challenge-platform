class RemoveLimitFromTwitterUsers < ActiveRecord::Migration
  def change
    change_column :users, :twitter, :string
  end
end
