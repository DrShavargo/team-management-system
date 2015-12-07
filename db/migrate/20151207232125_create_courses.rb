class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string    :course_code
      t.integer   :min_students
      t.integer   :max_students
      t.datetime  :deadline
    end
  end
end
