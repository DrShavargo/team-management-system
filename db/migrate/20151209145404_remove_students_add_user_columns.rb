class RemoveStudentsAddUserColumns < ActiveRecord::Migration
  def change
    drop_table :students
    add_column :users, :study_program, :string
    add_column :users, :course_section, :string
  end
end
