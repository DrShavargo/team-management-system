class Instructor < User
  has_many :courses, dependent: :destroy
end
