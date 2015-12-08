$(document).ready ->

  $(document).on 'click touchstart', '.course-list tr', (event) ->
    unless $(event.target).closest('a')[0]
      course_id = $(event.currentTarget).find('td.course-id').data("course")
      if course_id
        url = "http://" + location.host + "/courses/" + course_id
        window.location = url
