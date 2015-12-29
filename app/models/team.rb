class Team < ActiveRecord::Base
  resourcify

  belongs_to :course
  has_many :requests
  has_and_belongs_to_many :students, association_foreign_key: "user_id"

  def check_and_set_status
    self.status = (students.count > min_students) ? 'complete' : 'incomplete'
  end

  def is_complete?
    status == 'complete'
  end

  def set_status(as_status)
    self.status = as_status
  end

  def min_students
    course.min_students
  end

  def max_students
    course.max_students
  end

  def deadline
    course.deadline
  end

  def deadline_passed?
    deadline < DateTime.now
  end

  def get_students
    students = Array.new
    course.students.each do |student|
      students.push(student) unless student.has_team?(course)
    end
    students
  end

  def add_students_by_id(student_ids)
    student_ids.each do |student_id|
      students << Student.find(student_id) unless student_id.blank?
    end
  end

  def check_if_orphaned_after_user_removed
    if students.any?
      unless students.with_role(:liaison, self).any?
        students.first.add_role(:liaison, self)
      end
      return false
    else
      self.destroy
      return true
    end
  end

end
