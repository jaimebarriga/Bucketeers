generateString = (array) ->
  string = "<ul>"
  $.each array, (i, object) ->
    string += "<li class='suggest'>" + "<div class='name'>" + " " + object.name + "</div><div class='location'>" + object.location.city + ", " + object.location.country + "</div></li>"
  string += "</ul>"
  return string

search_places = (activity_name) ->
  console.log('starting')
  $.ajax
    url: "/users/search_places?name=#{activity_name}&country=Canada"
    type: "GET"
    success: (data) ->
      console.log(data)
      string = generateString(data)
      $('.suggestions').html(string);

$('#todo-list').on('click','li', ( ->
  place_name = $(this).find(".hashtag").text().slice(1)
  search_places(place_name)
));
