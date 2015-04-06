class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.integer :display_order
      t.string :title
      t.text :description
      t.references :steppable, polymorphic: true
      t.timestamps
    end
  end
end
