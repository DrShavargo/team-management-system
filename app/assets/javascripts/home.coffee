$(document).ready ->

  $(document).on 'click touchstart', '.course-list tr', (event) ->
    unless $(event.target).closest('a')[0]
      course_id = $(event.currentTarget).data("course")
      registered = $(event.currentTarget).data("registered")
      if course_id && registered
        url = "http://" + location.host + "/courses/" + course_id
        window.location = url
