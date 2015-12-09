module TeamsHelper
  def edit_team_button(team)
    link_to edit_team_path(team), class: 'btn btn-mini',
      data: { toggle: 'modal', target: '#modal-window', remote: true },
      id: 'edit-team-button' do
        content_tag :i, '', class: 'fa fa-edit'
    end
  end

  def request_join_team_button(team)
    link_to request_join_team_path(team), class: 'btn btn-mini',
      method: :post,
      data: { confirm: 'Are you certain you want to request membership to this team?' },
      id: 'request-join-team-button' do
        content_tag :i, '', class: 'fa fa-user-plus'
    end
  end

  def remove_student_team_button(team, student)
    link_to remove_student_team_path(team, student_id: student.id), class: 'btn btn-mini',
      method: :post,
      data: { confirm: 'Are you certain you want to remove this student from this team?' },
      id: 'remove-student-team-button' do
        content_tag :i, '', class: 'fa fa-user-times'
    end
  end

  def set_as_liaison_team_button(team, student)
    link_to set_as_liaison_team_path(team, student_id: student.id), class: 'btn btn-mini',
      method: :post,
      data: { confirm: 'Are you certain you want to set this student as liaison?' },
      id: 'set-liaison-team-button' do
        content_tag :i, '', class: 'fa fa-link'
    end
  end

  def accept_request_team_button(team, student)
    link_to accept_request_team_path(team, student_id: student.id), class: 'btn btn-mini',
      method: :post,
      data: { confirm: 'Are you certain you want to accept this request?' },
      id: 'accept-request-team-button' do
        content_tag :i, '', class: 'fa fa-user-plus'
    end
  end
end
