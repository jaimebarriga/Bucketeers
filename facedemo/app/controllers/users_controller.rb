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

    activity_obj = Activity.save_activity!(activity,user_id) # creates a new Tag if needed
    if activity_obj.blank?
      render json: { state: "failure", activity: activity}
    end
    tag_obj = Tag.find(activity_obj.tag_id)
    activity = activity.downcase
    activity.slice! (tag_obj.name)
    render json: { state: "success", activity: activity, activity_id: activity_obj.id, tag: tag_obj.name }
  end

  def all_activities
    user_id = params[:id]
    activities = Activity.get_all(user_id)
    render json: { state: "success", activities: activities.to_json}
  end

  def toggle_activity
    user_id = params[:id]
    activity_id = params[:activity_id]
    state = params[:state]

    state = Activity.toggle_state(activity_id,user_id,state)

    render json: { state: state, activity_id: activity_id }
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
    render json: User.get_places(params[:name], params[:country])
  end
end
