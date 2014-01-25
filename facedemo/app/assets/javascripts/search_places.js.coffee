search_places = (activity_name) ->
  $.ajax
    url: "/users/search_places?name=#{activity_name}&country=Canada"
    type: "GET"
    success: (data) ->
    	console.log(data)

search_places("skiing")

# $('#todo-list li').on('click' -> (
#   $(this)
# ));