class Team < ActiveRecord::Base
  belongs_to :course
  has_and_belongs_to_many :students

  def check_if_complete
  end

  def override_status
  end

end
