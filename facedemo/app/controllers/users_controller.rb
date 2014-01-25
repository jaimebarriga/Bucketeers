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
    else
      tag_obj = Tag.find(activity_obj.tag_id)
      # activity.slice! (/#\S+/)
      render json: { state: "success", activity: activity, activity_id: activity_obj.id, tag: tag_obj.name }
    end
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
    old_arr = (params[:current_friend_ids] || []).map{|friend_id| friend_id.to_i}
    complete_new_arr = Tag.get_all_activities_with_tag(tag_id,user_id)
    instructions = ListCommander.give_instructions(old_arr, complete_new_arr)
    render json: instructions
  end

  def create_event
    user = User.find(params[:id])
    event = user.create_event(params[:name], params[:date], params[:current_friend_uids])
    render json: event
  end

  def dashie
    @id = params[:id]
  end

  def search_places
    user = User.first
    render json: user.get_places(params[:name], params[:country])
  end
end
