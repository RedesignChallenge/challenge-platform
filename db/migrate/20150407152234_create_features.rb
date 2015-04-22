class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.text :reason
      t.string :category
      t.boolean :active
      t.references :user
      t.references :featured, polymorphic: true
      t.timestamps
    end

    add_index :features, [:featured_id, :featured_type]
  end
end
