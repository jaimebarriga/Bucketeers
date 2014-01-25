generateString = (array) ->
  string = "<ul>"
  $.each array, (i, object) ->
    string += "<li class='suggest'><div class='name'>"  + object.name + "</div>"
    string += "<div class='location'>" + object.location.city + ", " + object.location.country + "</div>"
    string += "<div class='overlay'>"
    string += "<a href='https://www.google.com/maps/preview/place/"+object.location.latitude+","+object.location.longitude
    string += "' target='_blank'><i class='fa fa-location-arrow'></i></a></div></li>"
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

put_link_to_hashtag = (str) ->
  return str.replace(/#\S+/, "<a class='hashtag'>$&</a>")

$('#todo-list').on('click','li', ( ->
  tag_id = $(this).attr('data-tag-id')
  tag_name = $(this).find(".hashtag").text()
  $('#tag-selected').html(put_link_to_hashtag(tag_name))
  $('#tag-selected').attr("data-tag-id",tag_id)
  place_name = $(this).find(".hashtag").text().slice(1)
  search_places(place_name)
))
