class Tag < ActiveRecord::Base
  has_many :activities
  has_many :users, through: :activities
  attr_accessible :name, :score

  # Get the name of the tag with the tag
  def get_name(tag_id)

  end

  # This function is calld by activity if a activity is created or deleted.
  def change_score(tag_id)

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
  def get_all_activities(tag_id, user_id)

  end

  def add_tag(tag_name)

  end
end
