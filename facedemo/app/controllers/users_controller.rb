class UsersController < ApplicationController

  def welcome
    
  end

  def dashboard
    @user = User.find(params[:id])
  end

  def add_activity
    # @user = User.find(params[:id])
    user_id = params[:id]
    activity = params[:activity]

    #state = Activity.save_activity!(activity,user_id) # creates a new Tag if needed

    render json: { state: "success", activity: activity }
  end

  def toggle_activity
    user_id = params[:id]
    activity = params[:activity]
    state = params[:state]

    #Activity.toggle_state(activity,user_id,state)

    render json: { state: "success", activity: activity }
  end

  def pre_event_tag_details
    user_id = params[:id]
    tag_id = params[:tag_id]
    current_friend_ids = params[:current_friend_ids].map{|friend_id| friend_id.to_i}
    arr = [
      {
        user_id: 3, # id of the User in our database
        user_name: "Mr. Kaboodle",
        user_profile_pic: "http:www.picture...",
        activity: "description 111 #eat"
      },
      {
        user_id: 5,
        user_name: "Ms. Panther",
        user_profile_pic: "http:www.picture...",
        activity: "description2 #football"
      },
      {
        user_id: 7,
        user_name: "Ms. Brazen",
        user_profile_pic: "http:www.picture...",
        activity: "description3 #mountainclimbing boo"
      }
    ]
    render json: arr
  end

  def dashie
    @id = params[:id]
  end

  def search_places
    user = User.first
    render json: user.get_places(params[:name], params[:country])
  end
end
