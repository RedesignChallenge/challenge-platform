class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :fipst

      t.string :name

      t.string :mail_street
      t.string :mail_city
      t.string :mail_state
      t.string :mail_zip
      t.string :mail_zip4
      t.string :phone

      t.string :number_of_members

      t.timestamps
    end

    add_index :states, :fipst, unique: true
  end
end
