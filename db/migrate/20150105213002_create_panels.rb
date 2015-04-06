class CreatePanels < ActiveRecord::Migration
  def change
    create_table :panels do |t|
      t.text :about
      
      t.references :challenge
      t.timestamps
    end
  end
end
