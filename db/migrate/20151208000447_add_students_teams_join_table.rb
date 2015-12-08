class AddStudentsTeamsJoinTable < ActiveRecord::Migration
  def up
    create_table :students_teams, :id => false do |t|
      t.integer :student_id
      t.integer :team_id
    end
  end

  def down
    drop_table :students_teams
  end
end
