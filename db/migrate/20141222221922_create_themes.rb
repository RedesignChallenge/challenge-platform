class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :title
      t.text :description

      t.references :experience_stage
      t.timestamps
    end
  end
end
