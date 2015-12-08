class AddMissingIds < ActiveRecord::Migration
  def change
    add_column :courses, :instructor_id, :integer
    add_column :teams, :course_id, :integer
  end
end
