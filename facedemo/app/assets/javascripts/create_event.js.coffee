POLL_DELAY = 2000
USER_ID = $('#user_id').text()

poll1 = () ->
  $.ajax
    url: "/users/#{USER_ID}/pre_event_tag_details"
    type: "POST"
    data: { tag_id: 45 }
    success: (data) ->
      # console.log("poll1")
      # console.log(data)
      fix_friend_activity_list(data)
      setTimeout (-> poll1(USER_ID) ), POLL_DELAY


poll2 = () ->
  $.ajax
    url: "/users/#{USER_ID}/add_activity"
    type: "POST"
    data: { activity: "boo #boo" }
    success: (data) ->
      # console.log("poll2")
      setTimeout (-> poll2() ), POLL_DELAY


setTimeout (-> poll1(USER_ID) ), 0.5*POLL_DELAY
setTimeout (-> poll2(USER_ID) ), POLL_DELAY


# Helper Functions

fix_friend_activity_list = (data) ->
  # get the template
  template = $('#friend_activity_template').clone()
  # $('#friend_activities ul').append('<li>'+template.html()+'</li>')

  # add_vehicle: (form) ->
  #   vehicle_form = @$('.vehicle_form').last().clone()
  #   vehicle_form.hide()
  #   @$(".end_of_vehicles").before(vehicle_form)
  #   vehicle_form.slideDown()
  #   @$('.vehicle_form').last().find('input').val('')
  #   @force_vin_for_cars(@$('.vehicle_form').last())
  #   @$('.vehicle_form').last().find('.control-group').removeClass('error')
  #   @$('.vehicle_form').last().find('span.help-inline').remove()
  #   @$('.destroy_vehicle').show()
  #   @$('#add_vehicle').hide() if @$('.vehicle_form').length >= 5 # Allow only up to 5 vehicles
  #   return false