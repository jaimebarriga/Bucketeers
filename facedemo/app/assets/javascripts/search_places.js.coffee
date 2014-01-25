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
>>>>>>> 579e580a76bae33f0f1a583c4381d37d98fa8040
