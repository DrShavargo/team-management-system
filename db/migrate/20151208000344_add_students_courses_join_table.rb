class AddStudentsCoursesJoinTable < ActiveRecord::Migration
  def up
    create_table :courses_users, :id => false do |t|
      t.integer :user_id
      t.integer :course_id
    end
  end

  def down
    drop_table :courses_users
  end
end
