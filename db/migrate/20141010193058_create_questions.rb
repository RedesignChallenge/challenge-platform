class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :description
      t.string :icon

      t.references :questionable, polymorphic: true
      t.timestamps
    end
  end
end