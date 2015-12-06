class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string    :course_code
      t.integer   :min_students
      t.integer   :max_students
      t.datetime  :deadline
      t.integer   :team_id
      t.string    :name
      t.datetime  :created_at
      t.string    :status
    end
  end
end
