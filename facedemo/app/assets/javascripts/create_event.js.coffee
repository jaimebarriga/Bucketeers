POLL_DELAY = 500
USER_ID = $('#user_id').text()

poll1 = () ->
  current_friend_ids = get_current_friend_ids()
  tag_id = get_tag_id_selected()
  data_to_send = { tag_id: tag_id, current_friend_ids: current_friend_ids }
  $.ajax
    url: "/users/#{USER_ID}/pre_event_tag_details"
    type: "POST"
    data: data_to_send
    success: (data) ->
      console.log(USER_ID)
      jQuery.each data, (i, instruction) ->
        console.log(instruction[0])
        if instruction[0] == "add"
          add_friend_activity(instruction[1],instruction[2])
        if instruction[0] == "delete"
          delete_friend_activity(instruction[1])
      setTimeout (-> poll1() ), POLL_DELAY

    error: (data) ->
      console.log(USER_ID)
      setTimeout (-> poll1() ), POLL_DELAY

setTimeout (-> poll1(USER_ID) ), 0


$(document).on('click', '#create_event_button', ( ->
  current_friend_uids = get_current_friend_uids()
  name = $('input[name="eventName"]').val() # HACK
  date = $('input[name="eventDate"]').val() # HACK
  data_to_send = { name: name, date: date, current_friend_uids: current_friend_uids }
  console.log(data_to_send)
  $.ajax
    url: "/users/#{USER_ID}/create_event"
    type: "POST"
    data: data_to_send
    success: (data) ->
      console.log(data)
      $('#myModal').foundation('reveal', 'close');
    error: (data) ->
      console.log("error")
));

# Helper Functions

get_tag_id_selected = () ->
  $('#tag-selected').attr('data-tag-id')

get_current_friend_uids = () ->
  user_uid_objects = $('#friend-activities .selected .user-uid')
  arr = jQuery.map(user_uid_objects, (user_id_object) ->
    user_id_object.innerHTML
  )
  return arr

get_current_friend_ids = () ->
  user_id_objects = $('#friend-activities .user-id')
  arr = jQuery.map(user_id_objects, (user_id_object) ->
    user_id_object.innerHTML
  )
  return arr

add_friend_activity = (activity_number_below,activity) ->
  template = $('#friend-activity-template').clone()
  template.find('.user-id').text(activity.user_id)
  template.find('.user-uid').text(activity.user_uid)
  template.find('.user-name').text(activity.user_name)
  template.find('.user-profile-pic img').attr("src", activity.profile_pic)
  template.find('.activity').text(activity.description)

  if activity_number_below == -1
    $('#friend-activities ul').append('<li>'+template.html()+'</li>')
  else
    $("#friend-activities ul li .user-id:contains(#{activity_number_below})").closest('li').before('<li>'+template.html()+'</li>')


delete_friend_activity = (user_id) ->
  friend_activity_to_delete = $("#friend-activities ul li .user-id:contains(#{user_id})").closest('li')
  friend_activity_to_delete.slideUp(500, -> $(this).remove())

$('button').on('click', ( =>
  $('#myModal').foundation('reveal', 'open');
))