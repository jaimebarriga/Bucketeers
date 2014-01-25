
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
  $this = $(this)
  checked = $this.prop('checked')
  $this.parent().parent().toggleClass('completed')
  if checked
    $this.prop('checked', true)
  else
    $this.prop('checked', false)
));

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


$('#add-new-item').on('submit', ( ->
  input = $(this).find('input');
  value = input.val();

  dataSend = 
    'activity': value
  $.ajax
    url: "/users/"+$('#user_id').text()+"/add_activity"
    data: dataSend
    type: "POST"
    success: (data) ->
      state = data.state
      if state=="success"
        value = data.activity
        tag = data.tag
        input.val("");
        html = '<li data-id="'+data.activity_id.toString()+'"><div class="view"><input class="toggle" type="checkbox">' +
         '<label>'+value+' <a class="hashtag">'+data.tag+'</a></label></div><form><input class="edit" type="text">'+
         '</form></li>'
        $('#todo-list').append(html);
      else if state =="failure"
        alert("Failure")
    error: (xhr, error) ->
      alert(error)

  return false
));

$('.your-bucket-list').on('click', '.toggle', ( ->
  $this = $(this)
  checked = $this.prop('checked')
  $this.parent().parent().toggleClass('completed')
  if checked
    $this.prop('checked', true)
  else
    $this.prop('checked', false)
));

$('#friend-activities').on('click', '.user-profile-pic', ( ->
  $(this).parent().toggleClass('selected')
));

