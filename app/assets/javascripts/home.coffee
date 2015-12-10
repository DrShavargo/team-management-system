$(document).ready ->

  $(document).on 'click touchstart', '.course-list tr', (event) ->
    unless $(event.target).closest('a')[0]
      course_id = $(event.currentTarget).data("course")
      registered = $(event.currentTarget).data("registered")
      if course_id && registered
        url = "http://" + location.host + "/courses/" + course_id
        window.location = url

  $(document).on 'click', '.js-message-can-close', (e) -> $(this).slideUp()

  $.rails.allowAction = (link) ->
    return true unless link.attr('data-confirm')
    $.rails.showConfirmDialog(link)
    false

  $.rails.confirmed = (link) ->
    link.removeAttr('data-confirm')
    link.trigger('click.rails')

  $.rails.showConfirmDialog = (link) ->
    message = link.attr 'data-confirm'
    html = """
      <div class="modal" id="confirmationDialog">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <a class="close" data-dismiss="modal">×</a>
              <h4>#{message}</h4>
            </div>
            <div class="modal-footer">
              <a data-dismiss="modal" class="btn">#{link.data('cancel')}</a>
              <a data-dismiss="modal" class="btn btn-warning confirm">#{link.data('ok')}</a>
            </div>
          </div>
        </div>
      </div>
      """
    $(html).modal()
    $('#confirmationDialog .confirm').on 'click', -> $.rails.confirmed(link)
