class Team < ActiveRecord::Base
  belongs_to :course
  has_and_belongs_to_many :students, association_foreign_key: "user_id"

  def check_if_complete
  end

  def override_status
  end

  def set_status(status)
  end

end
