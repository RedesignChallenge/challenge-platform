class StatesUsers < ActiveRecord::Migration
  def change
    create_table :states_users do |t|
      t.belongs_to :state
      t.belongs_to :user
    end
  end
end
