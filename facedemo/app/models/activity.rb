class Activity < ActiveRecord::Base
  belongs_to :tag
  belongs_to :user
  attr_accessible :desc, :state

  # Removes the activity and updates the score of the corresponding tag
  def self.delete_activity!(user_id, description)
  	activities = Activity.where(:user_id => user_id, :desc => description)
  	if activities.blank?
  	  return "failure"
  	end
  	#Tag.change_score_down(activities.first.tag_id)
  	activities.first.destroy
  	return "success"
  end

  def self.get_all(user_id)
    return Activity.where(:user_id => user_id)
  end

  # Returns the description string (e.g. "Go #eat")
  def get_description(user_id, tag_id)
  	return Activity.where(:user_id => user_id, :tag_id => tag_id).first.desc
  end

  # Returns the state of the activity
  def get_state(user_id, tag_id)
  	return Activity.where(:user_id => user_id, :tag_id => tag_id).first.state
  end


  def self.toggle_state(activity_id, user_id, state)
    #a = Activity.where(:user_id => user_id, :id => activity_id).first
    a = Activity.find(activity_id)
    if a.blank?
    	return "failure"
    end
    a.state = state
    a.save
    return "success"
  end

  # Creates new activity and new tag also if necessary
  # e.g. If "#eat" never existed, create new tag with name "#eat"
  def self.save_activity!(description,user_id)
    hashtags = description.scan(/#\S+/) # grabs all hashtags
    if hashtags.size != 1
      return nil

    end
    t = Tag.find_or_create_tag(hashtags.first.to_s.downcase)
    # Create new activity or modify existing one
  	a = Activity.where(:user_id => user_id, :tag_id => t.id).first
  	if a.present?
  	  return nil
  	end
  	a = Activity.new
  	a.desc = description
  	a.state = "Wish"
  	a.tag_id = t.id
  	a.user_id = user_id
  	a.save
  	#Tag.change_score_up(t.id) # increment the tag score
  	return a
  end
end
