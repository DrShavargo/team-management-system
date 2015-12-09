$(document).ready ->

  $(document).on 'click touchstart', '.my-team tr', (event) ->
    unless $(event.target).closest('a')[0]
      team_id = $(event.currentTarget).data("team")
      if team_id
        url = "http://" + location.host + "/teams/" + team_id
        window.location = url

  $(document).on 'click touchstart', '.team-list tr', (event) ->
    unless $(event.target).closest('a')[0]
      team_id = $(event.currentTarget).data("team")
      if team_id
        url = "http://" + location.host + "/teams/" + team_id
        window.location = url
