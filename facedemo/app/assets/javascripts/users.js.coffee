# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

console.log("users.js.coffee")

$(document).on('click', '#bucket_list #add_activity a', ( ->
  new_activity = $('#new_activity').val()
  return if new_activity == ""
  user_id = $('#user_id').text()
  $('#new_activity').val("")
  $('#bucket_list .activities').append('<li>'+new_activity+'</li>')
  console.log("/users/#{user_id}/add_activity")
  $.ajax
    url: "/users/#{user_id}/add_activity"
    type: "POST"
    data: { activity: new_activity }
    success: (data) ->
      console.log(data)
));