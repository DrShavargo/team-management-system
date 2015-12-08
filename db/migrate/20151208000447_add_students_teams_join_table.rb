class AddStudentsTeamsJoinTable < ActiveRecord::Migration
  def up
    create_table :teams_users, :id => false do |t|
      t.integer :user_id
      t.integer :team_id
    end
  end

  def down
    drop_table :teams_users
  end
end
