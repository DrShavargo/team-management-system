class User < ActiveRecord::Base
  rolify

  after_create :default_role

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

  def user_identifier
    name || email
  end

  def default_role
    type == "Student" ? add_role(:student) : add_role(:instructor)
  end

end
