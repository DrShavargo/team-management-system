class PagesController < ApplicationController
  before_action :authenticate_user!

  def router
    if user_signed_in?
      path = home_path
    else
      path = new_user_session_path
    end

    redirect_to path
  end

  def email_confirm_required
    redirect_to root_path if user_signed_in?
  end
end
