class User < ActiveRecord::Base
  rolify

  after_create :default_role

  # TODO Add :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable

  def user_identifier
    name || email
  end

  def default_role
    type == "Student" ? add_role(:student) : add_role(:instructor)
  end

end
