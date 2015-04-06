class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string :lea_id
      t.string :fipst
      t.string :stid

      t.string :name
      t.string :phone

      t.string :mail_street
      t.string :mail_city
      t.string :mail_state
      t.string :mail_zip
      t.string :mail_zip4

      t.string :location_street
      t.string :location_city
      t.string :location_state
      t.string :location_zip
      t.string :location_zip4

      t.string :_type
      t.string :union
      t.string :county_number
      t.string :county_name
      
      t.string :csa
      t.string :cbsa
      t.string :metmic
      t.string :ulocal
      t.string :cdcode

      t.string :latitude
      t.string :longitude
      
      t.string :bound
      t.string :biea

      t.string :lowest_grade
      t.string :highest_grade

      t.string :charter

      t.string :number_of_schools
      t.string :number_of_students
      t.string :number_of_k12s
      t.string :number_of_members
      t.string :number_of_speceds
      t.string :number_of_ells

      t.references :state

      t.timestamps
    end

    add_index :districts, :lea_id, unique: true
  end
end
