module CoursesHelper
  def edit_course_button(course)
    link_to edit_course_path(course), class: 'btn btn-mini',
      data: { toggle: 'modal', target: '#modal-window', remote: true },
      id: 'edit-course-button' do
        content_tag :i, '', class: 'fa fa-edit', 'title' => 'Edit'
    end
  end

  def delete_course_button(course)
    link_to course_path(course), class: 'btn btn-mini',
      method: :delete,
      data: {
        confirm: 'Are you certain you want to delete this course?',
        ok: 'Yes',
        cancel: 'No'
      },
      id: 'delete-course-button' do
        content_tag :i, '', class: 'fa fa-trash-o', 'title' => 'Delete'
    end
  end

  def register_course_button(course)
    link_to register_course_path(course), class: 'btn btn-mini',
      method: :post,
      data: {
        confirm: 'Are you certain you want to register for this course?',
        ok: 'Yes',
        cancel: 'No'
      },
      id: 'register-course-button' do
        content_tag :i, '', class: 'fa fa-user-plus', 'title' => 'Register'
    end
  end

  def unregister_course_button(course)
    link_to unregister_course_path(course), class: 'btn btn-mini',
      method: :post,
      data: {
        confirm: 'Are you certain you want to unregister from this course?',
        ok: 'Yes',
        cancel: 'No'
      },
      id: 'unregister-course-button' do
        content_tag :i, '', class: 'fa fa-user-times', 'title' => 'Unregister'
    end
  end
end
