class SchoolsUsers < ActiveRecord::Migration
  def change
    create_table :schools_users do |t|
      t.belongs_to :school
      t.belongs_to :user
    end
  end
end
