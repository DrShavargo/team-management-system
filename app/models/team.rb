class Team < ActiveRecord::Base
  resourcify

  belongs_to :course
  has_and_belongs_to_many :students, association_foreign_key: "user_id"

  def check_and_set_status
    if students.count.between?(min_students, max_students)
      self.status = 'complete'
    else
      self.status = 'incomplete'
    end
  end

  def is_complete?
    status == 'complete'
  end

  def set_status(as_status)
    self.status = as_status
  end

  def generate_from_create(student_ids)
    self.team_id = course.teams.count
    unless student_ids.blank?
      student_ids.each do |student_id|
        students << Student.find(student_id) unless student_id.blank?
      end
    end
    check_and_set_status
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

  def check_if_orphaned_after_user_removed
    if students.any?
      unless students.with_role(:liaison, self).any?
        students.first.set_role(:liaison, self)
      end
    else
      self.destroy
    end
  end

end
