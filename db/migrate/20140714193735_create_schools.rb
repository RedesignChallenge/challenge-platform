class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :nces_id
      t.string :fipst
      t.string :lea_id
      t.string :school_id
      
      t.string :stid
      t.string :sea_school_id
      t.string :lea_name
      
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
      t.string :status

      t.string :ulocal
      t.string :latitude
      t.string :longitude
      t.string :county_number
      t.string :county_name
      t.string :cdcode

      t.string :ft_teachers
      t.string :lowest_grade
      t.string :highest_grade
      t.string :level
      t.string :title1
      t.string :stitle1
      t.string :magnet
      t.string :charter
      t.string :shared
      t.string :bies

      t.references :district
      
      t.timestamps
    end

    add_index :schools, :nces_id, unique: true
  end
end
