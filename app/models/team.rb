class Team < ActiveRecord::Base
  resourcify

  belongs_to :course
  has_and_belongs_to_many :students, association_foreign_key: "user_id"

  def check_and_set_status
    if students.count > min_students
      self.status = 'complete'
    else
      self.status = 'incomplete'
    end

    !(students.count > max_students)
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
