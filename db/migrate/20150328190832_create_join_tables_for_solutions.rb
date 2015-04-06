class CreateJoinTablesForSolutions < ActiveRecord::Migration
  def change
    create_join_table :solutions, :experiences do |t|
      t.index :solution_id
      t.index :experience_id
    end

    create_join_table :solutions, :ideas do |t|
      t.index :solution_id
      t.index :idea_id
    end

    create_join_table :solutions, :approaches do |t|
      t.index :solution_id
      t.index :approach_id
    end
  end
end
