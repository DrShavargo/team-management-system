class Instructor < User
  has_many :course, dependent: :destroy
end
