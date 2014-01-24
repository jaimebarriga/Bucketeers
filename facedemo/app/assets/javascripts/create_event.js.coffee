POLL_DELAY = 2000

poll1 = () ->
  $.ajax
    url: "/users/10/add_activity"
    type: "POST"
    data: { activity: "boo #boo" }
    success: (data) ->
      # console.log("poll1")
      setTimeout (-> poll1() ), POLL_DELAY


poll2 = () ->
  $.ajax
    url: "/users/10/add_activity"
    type: "POST"
    data: { activity: "boo #boo" }
    success: (data) ->
      # console.log("poll2")
      setTimeout (-> poll2() ), POLL_DELAY


setTimeout (-> poll1() ), 0.5*POLL_DELAY
setTimeout (-> poll2() ), POLL_DELAY