class Instructor < User
  has_many :courses, dependent: :destroy

  def is_registered?(*)
    true
  end
end
