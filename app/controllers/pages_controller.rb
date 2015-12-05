class PagesController < ApplicationController
  before_action :authenticate_user!

  def router
    if current_user.authenticated?
      path = projects_path
    else
      path = new_user_session_path
    end

    redirect_to path
  end

  def email_confirm_required
    redirect_to root_path if current_user.authenticated?
  end
end
