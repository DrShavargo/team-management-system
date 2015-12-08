class Team < ActiveRecord::Base
  resourcify

  belongs_to :course
  has_and_belongs_to_many :students, association_foreign_key: "user_id"

  def check_if_complete
    if students.count.between?(min_students, max_students)
      self.status = 'complete'
    else
      self.status = 'incomplete'
    end
  end

  def override_status
    status = 'complete'
  end

  def generate_from_create(student_ids)
    self.team_id = course.teams.count
    unless student_ids.blank?
      student_ids.each do |student_id|
        students << Student.find(student_id) unless student_id.blank?
      end
    end
    check_if_complete
  end

  def min_students
    course.min_students
  end

  def max_students
    course.max_students
  end

  def check_if_orphaned_after_user_removed
    if students.any?
      unless students.with_role(:liaison).any?
        students.first.set_role(:liaison)
      end
    else
      self.destroy
    end
  end

end
