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
    path = 'register_course_path'
    data = {
        confirm: 'Are you certain you want to register for this course?',
        ok: 'Yes',
        cancel: 'No'
      }
    title = 'Register'
    icon = 'fa fa-user-plus'
    course_link_to(course, path, data, title, icon)
  end

  def unregister_course_button(course)
    path = 'unregister_course_path'
    data = {
          confirm: 'Are you certain you want to unregister from this course?',
          ok: 'Yes',
          cancel: 'No'
        }
    title = 'Unregister'
    icon = 'fa fa-user-times'
    course_link_to(course, path, data, title, icon)
  end

  def course_link_to(course, path, data, title, icon)
    link_to public_send(path, course), class: 'btn btn-mini',
      method: :post,
      data: data,
      id: 'accept-button' do
          content_tag :i, '', class: icon, 'title' => title
        end
  end
end
