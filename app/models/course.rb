class Course < ActiveRecord::Base
  has_one :instructor
  has_many :teams, dependent: :destroy
end
