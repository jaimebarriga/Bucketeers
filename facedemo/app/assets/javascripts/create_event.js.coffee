poll1 = () ->
  $.ajax
    url: "/users/10/add_activity"
    type: "POST"
    data: { activity: "boo #boo" }
    success: (data) ->
      console.log("poll1")
      poll1()


poll2 = () ->
  $.ajax
    url: "/users/10/add_activity"
    type: "POST"
    data: { activity: "boo #boo" }
    success: (data) ->
      console.log("poll2")
      poll2()

poll1()
poll2()