class Tag < ActiveRecord::Base
  has_many :activities
  has_many :users, through: :activities
  attr_accessible :name, :score


  # This function is calld to increment score by activity if a activity is created.
  def self.change_score_up(tag_id)
  	tag = Tag.find_by_id(tag_id)
  	tag.score += 1
  	tag.save
  	return tag.score
  end

  # This function is calld to increment score by activity if a activity is deleted.
  def self.change_score_down(tag_id)
  	tag = Tag.find_by_id(tag_id)
  	if (tag.score = 0)
  		return tag.score
  	end
  	tag.score -= 1
  	tag.save
  	return tag.score
  end

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
  def self.get_all_activities(tag_id, user_id)
  	activities = Activity.find(:all, :conditions => {:tag_id => tag_id}).sort_by { |activity| activity[:user_id] }
  	user = User.find_by_id(user_id)
  	user_friends = user.friends
  	response = []

  	activities.each do |activity|
  		
  		if activity.user_id == user.id
  			# Adding current users info and his activity info
  			response << {user_id: user.uid, user_name: user.name, description: activity.desc}
  		end

  		puts activity.desc
  		tag_matched_user = activity.user
  		is_match_with_friends = user_friends.detect {|friend| friend["id"] == tag_matched_user.uid }
  		unless is_match_with_friends.blank?
  			# Adding all the friend users info and their activity info
  			response << {user_id: tag_matched_user.uid, user_name: tag_matched_user.name, description: activity.desc}
  		end
  	end

  	return response
  end

  def add_tag(tag_name)
  	return Tag.find_or_create_by(name: tag_name)
  end
end