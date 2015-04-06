class CreateExperienceStages < ActiveRecord::Migration
  def change
    create_table :experience_stages do |t|
      t.string :title
      t.text :description
      t.boolean :active
      t.boolean :public
      t.datetime :starts_at
      t.datetime :ends_at

      t.references :challenge
      t.timestamps
    end
  end
end
