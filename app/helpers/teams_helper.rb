module TeamsHelper
  def edit_team_button(team)
    unless team.deadline_passed?
      link_to edit_team_path(team), class: 'btn btn-mini',
        data: { toggle: 'modal', target: '#modal-window', remote: true },
        id: 'edit-team-button' do
          content_tag :i, '', class: 'fa fa-edit', 'title' => 'Edit'
      end
    end
  end

  def request_join_team_button(team)
    unless team.deadline_passed?
      link_to request_join_team_path(team), class: 'btn btn-mini',
        method: :post,
        data: { confirm:
          'Are you certain you want to request membership to this team?',
          ok: 'Yes',
          cancel: 'No'
        },
        id: 'request-join-team-button' do
          content_tag :i, '', class: 'fa fa-user-plus', 'title' => 'Request to Join'
      end
    end
  end

  def remove_student_team_button(team, student)
    unless team.deadline_passed?
      link_to remove_student_team_path(team, student_id: student.id), class: 'btn btn-mini',
        method: :post,
        data: {
          confirm: 'Are you certain you want to remove this student from this team?',
          ok: 'Yes',
          cancel: 'No'
        },
        id: 'remove-student-team-button' do
          content_tag :i, '', class: 'fa fa-user-times', 'title' => 'Remove'
      end
    end
  end

  def set_as_liaison_team_button(team, student)
    unless team.deadline_passed?
      link_to set_as_liaison_team_path(team, student_id: student.id), class: 'btn btn-mini',
        method: :post,
        data: {
          confirm: 'Are you certain you want to set this student as liaison?',
          ok: 'Yes',
          cancel: 'No'
        },
        id: 'set-liaison-team-button' do
          content_tag :i, '', class: 'fa fa-link', 'title' => 'Set as Liaison'
      end
    end
  end

  def accept_request_team_button(team, student)
    unless team.deadline_passed?
      link_to accept_request_team_path(team, student_id: student.id), class: 'btn btn-mini',
        method: :post,
        data: {
          confirm: 'Are you certain you want to accept this request?',
          ok: 'Yes',
          cancel: 'No'
        },
        id: 'accept-request-team-button' do
          content_tag :i, '', class: 'fa fa-user-plus', 'title' => 'Accept'
      end
    end
  end
end
