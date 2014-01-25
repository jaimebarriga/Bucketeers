POLL_DELAY = 500
USER_ID = $('#user_id').text()

poll1 = (prev_tag_id) ->
  tag_id = get_tag_id_selected()
  if prev_tag_id != tag_id
    console.log("different")
    console.log(prev_tag_id)
    console.log(tag_id)
    $("#friend-activities li").slideUp(500, -> $(this).remove())
  current_friend_ids = get_current_friend_ids()
  data_to_send = { tag_id: tag_id, current_friend_ids: current_friend_ids }
  $.ajax
    url: "/users/#{USER_ID}/pre_event_tag_details"
    type: "POST"
    data: data_to_send
    success: (data) ->

      console.log('poll')
      show_or_hide_create_event_button()
      if tag_id > 0
        jQuery.each data, (i, instruction) ->
          if instruction[0] == "add"
            add_friend_activity(instruction[1],instruction[2])
          if instruction[0] == "delete"
            delete_friend_activity(instruction[1])
      setTimeout (-> poll1(tag_id) ), POLL_DELAY

    error: (data) ->
      console.log("error!")
      setTimeout (-> poll1(get_tag_id_selected()) ), POLL_DELAY


setTimeout (-> poll1(get_tag_id_selected()) ), 0


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

show_or_hide_create_event_button = () ->
  if get_current_friend_uids().length == 0
    $('#addEvent').hide()
  else
    $('#addEvent').show()

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
