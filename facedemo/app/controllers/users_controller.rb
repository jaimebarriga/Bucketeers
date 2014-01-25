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

    # Activity.save_activity!(activity,user_id) # creates a new Tag if needed

    render json: { state: "success", activity: activity }
  end

  def pre_event_tag_details
    user_id = params[:id]
    tag_id = params[:tag_id]
    old_arr = (params[:current_friend_ids] || []).map{|friend_id| friend_id.to_i}
    complete_new_arr = Tag.get_all_activities(tag_id,user_id)
    instructions  = ListCommander.give_instructions(old_arr, complete_new_arr)
    render json: instructions
  end

  def dashie
    @id = params[:id]
  end

end
