class TeamsController < ApplicationController
  respond_to :html, :js

  def show
    @team = Team.where(id: team_id).first
    @requests = Array.new
    @team.requests.each do |request|
      @requests.push(Student.where(id: request.requestor_id).first)
    end
    if current_user.has_role?(:student)
      if current_user.teams.where(id: team_id).empty?
        redirect_to course_path(@team.course), alert: 'You cannot view this team!'
      end
    end
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
    unless params[:team][:student_ids].nil?
      params[:team][:student_ids] = params[:team][:student_ids][0, course.max_students]
    end
    team = course.teams.create(team_params)
    team.students << current_user
    team.team_id = team.id

    valid_student_count = team.check_and_set_status
    if valid_student_count
      team.save

      current_user.add_role(:liaison, team)

      if team.valid?
        flash[:success] = "Team created successfully!"
        redirect_to team_path(team)
      else
        flash[:error] = team.errors.full_messages
        redirect_to course_path(course)
      end
    else
      team.destroy
      redirect_to course_path(course), alert: 'Too many students selected.'
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
    team = Team.find(team_id)
    team.set_status('complete')
    team.save

    if team.valid?
      redirect_to team_path(team), notice: 'The team\'s status was updated successfully!'
    else
      redirect_to team_path(team), alert: 'The team\'s status failed to update.'
    end
  end

  def incomplete
    team = Team.find(team_id)
    team.set_status('incomplete')
    team.save

    if team.valid?
      redirect_to team_path(team), notice: 'The team\'s status was updated successfully!'
    else
      redirect_to team_path(team), alert: 'The team\'s status failed to update.'
    end
  end

  def request_join
    team = Team.find(team_id)
    request = team.requests.create({:requestor_id => current_user.id, :status => 'pending'})
    request.save

    if request.valid?
      redirect_to course_path(team.course), notice: 'Your request has been sent!'
    else
      redirect_to course_path(team.course), alert: 'There was a problem sending your request.'
    end
  end

  def leave
    team = Team.find(team_id)
    course = team.course
    team.students.delete(current_user)
    current_user.remove_role(:liaison, team) if current_user.has_role?(:liaison, team)
    team.check_if_orphaned_after_user_removed
    redirect_to course_path(course), notice: 'You have been removed from the team.'
  end

  def add_student
    if request.get?
      @team = Team.find(team_id)
      @students = Array.new
      @team.course.students.each do |student|
        @students.push(student) unless student.has_team?(@team.course)
      end
    elsif request.post?
      team = Team.find(team_id)
      params[:team][:student_ids] = params[:team][:student_ids][0, team.max_students - team.students.count]
      params[:team][:student_ids].each do |student_id|
        team.students << Student.find(student_id) unless student_id.blank?
      end
      redirect_to team_path(team), notice: 'Students have been added successfully!'
    end
  end

  def remove_student
    team = Team.find(team_id)
    course = team.course
    student = Student.find(student_id)
    team.students.delete(student)
    if (team.check_if_orphaned_after_user_removed)
      redirect_to course_path(course), notice: 'Student has been removed fromt he team.'
    else
      redirect_to team_path(team), notice: 'Student has been removed fromt he team.'
    end
  end

  def set_as_liaison
    team = Team.find(team_id)
    student = Student.find(student_id)
    current_user.remove_role(:liaison, team)
    student.add_role(:liaison, team)
    redirect_to team_path(team), notice: 'New team liaison has been set.'
  end

  def accept_request
    team = Team.find(team_id)
    if team.is_complete?
      redirect_to team_path(team), alert: 'Cannot add new member to full team!'
    else
      team.students << Student.find(student_id)
      request = team.requests.where(requestor_id: student_id).first
      request.destroy
      redirect_to team_path(team), notice: 'New member added to team.'
    end
  end

  private

    def team_params
      params.require(:team).permit(:course_id, :name, :student_ids => [])
    end

    def course_id
      params.require(:course_id)
    end

    def team_id
      params.require(:id)
    end

    def student_id
      params.require(:student_id)
    end
end
