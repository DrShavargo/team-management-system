class Course < ActiveRecord::Base
  belongs_to :instructor
  has_many :teams, dependent: :destroy
  has_and_belongs_to_many :students, association_foreign_key: "user_id"
end
