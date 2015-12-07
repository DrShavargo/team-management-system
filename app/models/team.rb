class Team < ActiveRecord::Base
  has_many :students
  has_one :course

  def check_if_complete
  end

  def override_status
  end

end
