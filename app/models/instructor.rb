class Instructor < User
  has_many :courses, dependent: :destroy

  def is_registered?(course)
    true
  end
end
