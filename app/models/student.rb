class Student < User
  has_and_belongs_to_many :courses, foreign_key: "user_id"
  has_and_belongs_to_many :teams, foreign_key: "user_id"

  def has_team?(course)
    teams.where(course_id: course.id).any?
  end

  def is_registered?(course)
    courses.where(id: course.id).exists?
  end
end
