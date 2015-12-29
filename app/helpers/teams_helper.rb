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
    path = 'remove_student_team_path'
    data = {
          confirm: 'Are you certain you want to remove this student from this team?',
          ok: 'Yes',
          cancel: 'No'
        }
    title = 'Remove'
    icon = 'fa fa-user-times'
    dynamic_link_to(team, student, path, data, title, icon)
  end

  def set_as_liaison_team_button(team, student)
    path = 'set_as_liaison_team_path'
    data = {
          confirm: 'Are you certain you want to set this student as liaison?',
          ok: 'Yes',
          cancel: 'No'
        }
    title = 'Set as Liaison'
    icon = 'fa fa-link'
    dynamic_link_to(team, student, path, data, title, icon)
  end

  def accept_request_team_button(team, student)
    path = 'accept_request_team_path'
    data = {
            confirm: 'Are you certain you want to accept this request?',
            ok: 'Yes',
            cancel: 'No'
          }
    title = 'Accept'
    icon = 'fa fa-user-plus'
    dynamic_link_to(team, student, path, data, title, icon)
  end

  def dynamic_link_to(team, student, path, data, title, icon)
    unless team.deadline_passed?
      link_to public_send(path, team, student_id: student.id), class: 'btn btn-mini',
        method: :post,
        data: data,
        id: 'accept-button' do
            content_tag :i, '', class: icon, 'title' => title
      end
    end
  end
end
