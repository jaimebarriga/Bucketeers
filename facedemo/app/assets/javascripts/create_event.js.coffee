poll1 = () ->
  $.ajax
    url: "/users/10/add_activity"
    type: "POST"
    data: { activity: "boo #boo" }
    success: (data) ->
      poll1()


poll2 = () ->
  $.ajax
    url: "/users/10/add_activity"
    type: "POST"
    data: { activity: "boo #boo" }
    success: (data) ->
      poll2()

poll1()
poll2()