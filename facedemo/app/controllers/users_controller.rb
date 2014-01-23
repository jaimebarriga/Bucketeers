class UsersController < ApplicationController

  def welcome
    
  end

  def dashboard
    @user = User.find(params[:id])
  end

  def add_activity
    @user = User.find(params["id"])
    activity = params["activity"]
    hashtags = activity.scan(/#\S+/) # grabs all hashtags 
    # add the hashtags
    render json: { state: "success", user_id: @user.id, activity: activity }
  end

end
