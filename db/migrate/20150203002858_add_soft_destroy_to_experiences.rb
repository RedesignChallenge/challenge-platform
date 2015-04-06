class AddSoftDestroyToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :destroyed_at, :datetime
  end
end
