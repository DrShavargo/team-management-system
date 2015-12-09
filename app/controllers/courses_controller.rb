class CoursesController < ApplicationController
  respond_to :js

  def show
    @course = current_user.courses.find(course_id)
    if current_user.has_role?(:instructor)
      @teams = @course.teams
    else
      @teams = @course.teams.where(status: 'incomplete')
      @my_team = current_user.teams.where(course_id: @course.id).first
    end
  end

  def new
    @course = Course.new
  end

  def edit
    @course = current_user.courses.find(course_id)
    unless @course.valid?
      redirect_to root_path, alert: 'You cannot update this course!'
    end
  end

  def create
    convert_date
    course = current_user.courses.create(courses_params)
    course.save

    if course.valid?
      redirect_to course_path(course)
    else
      flash[:error] = course.errors.full_messages
      redirect_to root_path
    end
  end

  def update
    convert_date
    course = current_user.courses.find(course_id)
    if course.update(courses_params)
      course.update_team_statuses
      redirect_to root_path, notice: 'The course was updated successfully!'
    else
      redirect_to root_path, alert: 'The course failed to update.'
    end
  end

  def destroy
    course = current_user.courses.find(course_id)
    course.destroy
    redirect_to root_path, notice: 'The course was deleted successfully.'
  end

  def register
    course = Course.find(course_id)
    current_user.courses << course unless current_user.courses.include?(course)
    current_user.course_section = "A"
    redirect_to course_path(course)
  end

  def unregister
    course = Course.find(course_id)
    course.students.delete(current_user)

    team = current_user.teams.where(course_id: course.id).first
    unless team.blank?
      team.students.delete(current_user)
      current_user.remove_role(:liaison, team) if current_user.has_role?(:liaison, team)
      team.check_if_orphaned_after_user_removed
    end

    redirect_to root_path
  end

  def convert_date
    params[:course][:deadline] = DateTime.parse(params[:course][:deadline])
  end

  private

    def courses_params
      params.require(:course).permit(:course_code, :min_students, :max_students, :deadline)
    end

    def course_id
      params.require(:id)
    end

end
