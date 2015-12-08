class TeamsController < ApplicationController
  respond_to :json, :js

  def new
    @course = current_user.courses.find(course_id)
    @students = Array.new
    @course.students.each do |student|
      @students.push(student) unless student.teams.where(course_id == @course.id).any?
    end
    @students.delete(current_user)
    @team = Team.new
  end

  def create
    course = current_user.courses.find(params[:team][:course_id])
    team = course.teams.create(team_params)
    team.created_at = Time.now
    team.team_id = course.teams.count

    params[:team][:student_ids].each do |student_id|
      team.students << Student.find(student_id) unless student_id.blank?
    end
    team.students << current_user

    team.save

    if team.valid?
      redirect_to team_path(team)
    else
      flash[:error] = team.errors.full_messages
      redirect_to course_path(course)
    end
  end

  def edit
  end

  def update
  end

  def request_join
  end

  private

    def team_params
      params.require(:team).permit(:course_id, :name)
    end

    def course_id
      params.require(:course_id)
    end
end
