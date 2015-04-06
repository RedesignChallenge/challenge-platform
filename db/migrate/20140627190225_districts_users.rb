class DistrictsUsers < ActiveRecord::Migration
  def change
    create_table :districts_users do |t|
      t.belongs_to :district
      t.belongs_to :user
    end
  end
end
