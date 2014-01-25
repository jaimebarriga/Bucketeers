search_places = (activity_name) ->
  $.ajax
    url: "/users/search_places?name=#{activity_name}&country=Canada"
    type: "GET"
    success: (data) ->
      $('.suggestions').text(JSON.stringify(data))

# duplicate
put_link_to_hashtag = (str) ->
  return str.replace(/#\S+/, "<a class='hashtag'>$&</a>")

$(document).on('click', '#todo-list li', ( ->
  $(".friend-activity.intro").remove()
  tag_id = $(this).attr('data-tag-id')
  tag_name = $(this).find(".hashtag").text()
  $('#tag-selected').html(put_link_to_hashtag(tag_name))
  $('#tag-selected').attr("data-tag-id",tag_id)
  $place_name = tag_name.slice(1)
  search_places("skiing")
));