require 'ostruct'

class Account
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :email, :person_id, :study_program

  delegate :name, :email, :person_id, :study_program, to: :user

  def persisted?
    false
  end

  def initialize(user)
    @user = user
  end

  def user
    @user
  end

  def update_attributes(params = {})
    unless @user.update(account_params(params))
      self.errors.add(*@user.errors.first)
    end
  end

  private

    def account_params(params)
      params.permit(:name, :email, :person_id, :study_program)
    end
end
