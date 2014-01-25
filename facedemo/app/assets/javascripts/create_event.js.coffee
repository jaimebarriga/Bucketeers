POLL_DELAY = 5000
USER_ID = $('#user_id').text()

poll1 = () ->
  $.ajax
    url: "/users/#{USER_ID}/pre_event_tag_details"
    type: "POST"
    data: { tag_id: 45 }
    success: (data) ->
      # console.log("poll1")
      # console.log(data)
      # fix_friend_activity_list(data)
      add_friend_activity(1,data[0])
      add_friend_activity(2,data[1])
      add_friend_activity(-1,data[2])
      delete_friend_activity(5)
      # setTimeout (-> poll1(USER_ID) ), POLL_DELAY


poll2 = () ->
  $.ajax
    url: "/users/#{USER_ID}/add_activity"
    type: "POST"
    data: { activity: "boo #boo" }
    success: (data) ->
      # console.log("poll2")
      setTimeout (-> poll2() ), POLL_DELAY


setTimeout (-> poll1(USER_ID) ), 0
setTimeout (-> poll2(USER_ID) ), POLL_DELAY


# Helper Functions


add_friend_activity = (activity_number_below,activity) ->
  template = $('#friend_activity_template').clone()
  template.find('.user_id').text(activity.user_id)
  template.find('.user_name').text(activity.user_name)
  template.find('.user_profile_pic').text(activity.user_profile_pic)
  template.find('.activity').text(activity.activity)
  if activity_number_below == -1
    $('#friend_activities ul').append('<li>'+template.html()+'</li>')
  else
    $('#friend_activities ul li:nth-child(' + activity_number_below + ')').before('<li>'+template.html()+'</li>')


delete_friend_activity = (user_id) ->
  friend_activity_to_delete = $("#friend_activities ul li .user_id:contains(#{user_id})").closest('li')
  friend_activity_to_delete.slideUp(500, -> $(this).remove())
