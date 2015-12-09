class TeamsController < ApplicationController
  respond_to :json, :js

  def show
    @team = current_user.teams.where(team_id: team_id).first
  end

  def new
    @course = current_user.courses.find(course_id)
    @students = Array.new
    @course.students.each do |student|
      @students.push(student) unless student.has_team?(@course)
    end
    @students.delete(current_user)
    @team = Team.new
  end

  def create
    course = current_user.courses.find(team_params[:course_id])
    team = course.teams.create(team_params)
    team.students << current_user
    team.generate_from_create(team_params[:student_ids])
    team.save

    current_user.add_role(:liaison, team)

    if team.valid?
      redirect_to team_path(team)
    else
      flash[:error] = team.errors.full_messages
      redirect_to course_path(course)
    end
  end

  def edit
    @team = current_user.teams.find(team_id)
    unless @team.valid?
      redirect_to root_path, alert: 'You cannot update this course!'
    end
  end

  def update
    team = current_user.teams.find(team_id)
    if team.update(team_params)
      redirect_to course_path(team.course), notice: 'The course was updated successfully!'
    else
      redirect_to course_path(team.course), alert: 'The course failed to update.'
    end
  end

  def complete
  end

  def incomplete
  end

  def request_join
  end

  def leave
  end

  def add_student
  end

  def remove_student
  end

  def set_as_liaison
  end

  private

    def team_params
      params.require(:team).permit(:course_id, :name, :student_ids)
    end

    def course_id
      params.require(:course_id)
    end

    def team_id
      params.require(:id)
    end
end
