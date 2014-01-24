class UsersController < ApplicationController

  def welcome
    
  end

  def dashboard
    @user = User.find(params[:id])
  end

  def add_activity
    # @user = User.find(params["id"])
    activity = params["activity"]
    hashtags = activity.scan(/#\S+/) # grabs all hashtags 
    # add the hashtags
    render json: { state: "success", hashtag: hashtags, activity: activity }
  end

  def dashie
    @id = params[:id]
  end

end
