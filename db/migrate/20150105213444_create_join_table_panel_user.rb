class CreateJoinTablePanelUser < ActiveRecord::Migration
  def change
    create_join_table :panels, :users do |t|
      t.index :panel_id
      t.index :user_id
    end
  end
end
