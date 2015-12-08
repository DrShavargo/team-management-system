class AddStudentsCoursesJoinTable < ActiveRecord::Migration
  def up
    create_table :students_courses, :id => false do |t|
      t.integer :student_id
      t.integer :course_id
    end
  end

  def down
    drop_table :students_courses
  end
end
