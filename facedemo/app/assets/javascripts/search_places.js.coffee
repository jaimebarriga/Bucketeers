search_places = (activity_name) ->
  $.ajax
    url: "/users/search_places?name=#{activity_name}&country=Canada"
    type: "GET"
    success: (data) ->
    	console.log(data)
    	$('.suggestions').text(JSON.stringify(data))

$('#todo-list li').on('click', ( ->
  $place_name = $(this).find(".hashtag").text().slice(1)
  search_places("skiing")
));