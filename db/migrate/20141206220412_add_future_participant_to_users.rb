class AddFutureParticipantToUsers < ActiveRecord::Migration
  def change
    add_column :users, :future_participant, :boolean, default: true
  end
end
