module CoursesHelper
  def edit_course_button(course)
    link_to edit_course_path(course), class: 'btn btn-mini',
      data: { toggle: 'modal', target: '#modal-window', remote: true },
      id: 'edit-course-button' do
        content_tag :i, '', class: 'fa fa-edit'
    end
  end

  def delete_course_button(course)
    link_to course_path(course), class: 'btn btn-mini',
      method: :delete,
      data: { confirm: 'Are you certain you want to delete this course?' },
      id: 'delete-course-button' do
        content_tag :i, '', class: 'fa fa-trash-o'
    end
  end
end
