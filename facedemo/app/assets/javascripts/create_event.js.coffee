POLL_DELAY = 5000
USER_ID = $('#user_id').text()

poll1 = () ->
  current_friend_ids = get_current_friend_ids()
  tag_id = 1 # Erik
  data_to_send = { tag_id: tag_id, current_friend_ids: current_friend_ids }
  $.ajax
    url: "/users/#{USER_ID}/pre_event_tag_details"
    type: "POST"
    data: data_to_send
    success: (data) ->
      # console.log("poll1")
      jQuery.each data, (i, instruction) ->
        console.log(instruction[0])
        if instruction[0] == "add"
          console.log("adding")
          console.log(instruction[1])
          console.log(instruction[2])
          add_friend_activity(instruction[1],instruction[2])
        if instruction[0] == "delete"
          delete_friend_activity(instruction[1])
      # fix_friend_activity_list(data)
      # add_friend_activity(1,data[0])
      # add_friend_activity(2,data[1])
      # add_friend_activity(-1,data[2])
      # delete_friend_activity(5)
      # setTimeout (-> poll1(USER_ID) ), POLL_DELAY
    error: (data) ->
      console.log("error!")

# poll2 = () ->
#   $.ajax
#     url: "/users/#{USER_ID}/add_activity"
#     type: "POST"
#     data: { activity: "boo #boo" }
#     success: (data) ->
#       # console.log("poll2")
#       setTimeout (-> poll2() ), POLL_DELAY


setTimeout (-> poll1(USER_ID) ), 0
# setTimeout (-> poll2(USER_ID) ), POLL_DELAY


# Helper Functions

get_current_friend_ids = () ->
  user_id_objects = $('#friend-activities .user-id')
  arr = jQuery.map(user_id_objects, (user_id_object) ->
    user_id_object.innerHTML
  )
  return arr

add_friend_activity = (activity_number_below,activity) ->
  template = $('#friend-activity-template').clone()
  template.find('.user-id').text(activity.user_id)
  template.find('.user-name').text(activity.user_name)
  template.find('.user-profile-pic').text(activity.user_profile_pic)
  template.find('.activity').text(activity.activity)
  console.log(template.html())
  if activity_number_below == -1
    $('#friend-activities ul').append('<li>'+template.html()+'</li>')
  else
    $("#friend-activities ul li .user-id:contains(#{activity_number_below})").closest('li').before('<li>'+template.html()+'</li>')


delete_friend_activity = (user_id) ->
  friend_activity_to_delete = $("#friend-activities ul li .user-id:contains(#{user_id})").closest('li')
  friend_activity_to_delete.slideUp(500, -> $(this).remove())
