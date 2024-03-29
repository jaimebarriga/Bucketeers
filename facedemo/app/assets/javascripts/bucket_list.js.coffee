
$(document).on('click', '#bucket_list #add_activity a', ( ->
  user_id = $('#user_id').text()
  new_activity = $('#new_activity').val();
  addActivity(user_id,new_activity);
));


addActivity = (user_id,new_activity) ->
  return if user_id == ""
  return if new_activity == ""
  $('#new_activity').val("")
  $('#bucket_list .activities').append('<li>'+new_activity+'</li>')
  console.log("/users/#{user_id}/add_activity")
  $.ajax
    url: "/users/10/add_activity"
    type: "POST"
    data: { activity: new_activity }
    success: (data) ->
      console.log(data)

bucketList = $('#bucket-list')
bucketList.on('click', '.toggle', ( ->
  li_item = $(this).parent().parent()
  completed = !li_item.hasClass('completed')
  alert("new state: "+completed)
  dataSend = 
    "activity_id": li_item.data('id')
    "state": completed
  $.ajax ->
    url: "/users/"+$('#user_id').text()+"/toggle_activity"
    data: dataSend
    type: "POST"
    success: (data) ->
      state = data.state
      if state == "success"
        li_item.toggleClass('completed')
))

showJoinMessage = () ->
  message = $('#join-message')
  message.fadeIn()
  delay = () ->
    message.fadeOut()
  setTimeout(delay,1500)

bucketForm = $('#bucket-list-form')
bucketForm.on('submit', ( ->
  if $('.new').length == 3
    showJoinMessage()
    return false;
  input = $(this).find('input');
  value = input.val();
  input.val("");
  html = '<li class="new"><div class="view"><input class="toggle" type="checkbox">' +
         '<label>'+value+'</label></div><form><input class="edit" type="text">'+
         '</form></li>'
  $('#todo-list').append(html);

  return false
));

list = $('#todo-list')
filters = $('.filter');

$('.all').on('click', ( -> 
  filters.removeClass('selected');
  $(this).addClass('selected')
  list.removeClass().addClass('show-all')
  return
));
$('.active').on('click', ( ->
  filters.removeClass('selected');
  $(this).addClass('selected')
  list.removeClass().addClass('show-active')
  return
));
$('.complete').on('click', ( ->
  filters.removeClass('selected');
  $(this).addClass('selected')
  list.removeClass().addClass('show-completed')
  return
));

put_link_to_hashtag = (str) ->
  return str.replace(/#\S+/, "<a class='hashtag'>$&</a>")

$('#add-new-item').on('submit', ( ->
  input = $(this).find('input');
  value = input.val();
  console.log("starting")

  dataSend = 
    'activity': value
  $.ajax
    url: "/users/"+$('#user_id').text()+"/add_activity"
    data: dataSend
    type: "POST"
    success: (data) ->
      state = data.state
      if state=="success"
        console.log(data)
        value = data.activity
        tag = data.tag
        activity_label = put_link_to_hashtag(data.activity)
        input.val("");
        html =  "<li data-id='"+data.activity_id.toString()+"' data-tag-id='"+data.tag_id.toString()+"'><div class='view'><input class='toggle' type='checkbox'>"
        html += "<label>"
        html += activity_label
        html += "</label></div><form><input class='edit' type='text'>"
        html += "</form></li>"
        $('#todo-list').append(html);
      else if state =="failure"
        console.log("Oops, you already have that")
        input.val("");
    error: (xhr, error) ->

  return false
));

$('.your-bucket-list').on('click', '.toggle', ( ->
  li_item = $(this).parent().parent()
  completed = !li_item.hasClass('completed')
  a_id = li_item.data('id')
  dataSend = 
    'activity_id': li_item.data('id')
    'state': completed
  $.ajax
    url: "/users/"+$('#user_id').text()+"/toggle_activity"
    data: dataSend
    type: "POST"
    success: (data) ->
      state = data.state
      if state == "success"
        li_item.toggleClass('completed')
      else if state =="failure"
        console.log("Failure! something went wrong")

  return false
));

$('#friend-activities').on('click', '.user-profile-pic', ( ->
  $(this).parent().toggleClass('selected')
));
