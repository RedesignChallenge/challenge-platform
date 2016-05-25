class AddChallengeToFeatures < ActiveRecord::Migration
  def change
    add_reference :features, :challenge, index: true, null: false
  end
end
