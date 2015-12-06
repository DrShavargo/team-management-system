class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
       t.string :study_program
       t.string :course_section
    end
  end
end
