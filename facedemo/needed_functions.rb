class User < ActiveRecord::Base

  # WARNING: Make sure that all of the users from `user.friends_who_installed_app` are in your database.
  # All of your friends_who_installed_app must sign in to your computer at least once
  # else the program will try to access a user not in your database


  # Erik, i'll take care of this
  def profile_picture
    "http:www.picture..."
  end


  # Might not need to be written (depending on the data structures)
  # Array of "activity" objects (not descriptions only)
  def activities

  end


  # intersection of user.friends_who_installed_app & tag.friends
  def friends_with_same_tag(tag_id)

  end

  # Will be used by tag.friends_of_user_with_activities(user_id)
  #   {
  #     user_id: 3, # id of the User in our database
  #     user_name: "Mr. Kaboodle",
  #     user_profile_pic: "http:www.picture...",
  #     activity: "description 111 #eat"
  #   }
  def activity_info_for_tag(tag_id)

  end


end





class Tag < ActiveRecord::Base

  # This function will be used for our "middle" column
  # Gives an array of user.activity_info_for_tag(tag_id) of user.friends_with_same_tag(tag_id)
  # [
  #   {
  #     user_id: 3, # id of the User in our database
  #     user_name: "Mr. Kaboodle",
  #     user_profile_pic: "http:www.picture...",
  #     activity: "description 111 #eat"
  #   },
  #   {
  #     user_id: 5,
  #     user_name: "Ms. Panther",
  #     user_profile_pic: "http:www.picture...",
  #     activity: "description2 #football"
  #   },
  #   {
  #     user_id: 7,
  #     user_name: "Ms. Brazen",
  #     user_profile_pic: "http:www.picture...",
  #     activity: "description3 #mountainclimbing boo"
  #   }
  # ]
  def friends_of_user_with_activities(user_id)

  end

end




class Activity < ActiveRecord::Base

  # Returns the string (e.g. "Go #eat")
  def description(user_id, tag_id)

  end

  # Creates new activity and new tag also if necessary
  # e.g. If "#eat" never existed, create new tag with name "#eat"
  def self.save_activity(tag)

  end

end




class Event < ActiveRecord::Base
  
  # Erik, not sure

  # save the event_id, and creator_id for now

end