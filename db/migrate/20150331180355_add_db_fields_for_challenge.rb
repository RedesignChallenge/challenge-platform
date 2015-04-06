class AddDbFieldsForChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :incentive, :text
  	add_column :challenges, :cta, :string
    add_column :challenges, :banner, :string #carrierwave mounted image

    add_column :approach_stages, :incentive, :text
  end
end
