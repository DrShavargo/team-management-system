module TeamsHelper
  def edit_team_button(team)
    link_to edit_team_path(team), class: 'btn btn-mini',
      data: { toggle: 'modal', target: '#modal-window', remote: true },
      id: 'edit-course-button' do
        content_tag :i, '', class: 'fa fa-edit'
    end
  end
end
