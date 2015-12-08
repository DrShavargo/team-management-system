class HomeController < ApplicationController
  def index
    if current_user.has_role?(:instructor)
      @courses = current_user.courses
    else
      @courses = Course.all
    end
  end
end
