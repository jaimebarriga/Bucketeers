search_places = (activity_name) ->
  $.ajax
    url: "/users/search_places?name=#{activity_name}&country=Canada"
    type: "GET"
    success: (data) ->
      console.log(data)
      use = data[0]
      name = use.name
      city = use.location.city
      country = use.location.country
      $('.suggestions').text(name+' '+city+' '+country);

$('#todo-list li').on('click', ( ->
  $place_name = $(this).find(".hashtag").text().slice(1)
  search_places("skiing")
));
