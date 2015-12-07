require 'ostruct'

class Account
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :email, :person_id

  delegate :name, :email, :person_id, to: :user

  def persisted?
    false
  end

  def initialize(user)
    @user = user
  end

  def user
    @user
  end

  def email_settings
    OpenStruct.new(@user.to_settings_hash[:email])
  end

  def update_attributes(params = {})
    unless @user.update(account_params(params))
      self.errors.add(*@user.errors.first)
    end
  end

  private

    def account_params(params)
      params.permit(:name, :email, :person_id, :phone, :time_zone, :default_address_id)
    end
end
