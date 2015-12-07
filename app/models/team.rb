class Team < ActiveRecord::Base
  has_many :students

  def check_if_complete
  end

  def override_status
  end

end
