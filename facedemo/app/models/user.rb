require 'net/http'
require 'net/https'

class User < ActiveRecord::Base
  has_many :activities
  has_many :tags, through: :activities
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Facebook Graph API
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def graph_api
    Koala::Facebook::API.new(self.oauth_token)
  end

  def profile
    self.graph_api.get_object('me')
  end

  def friends
    self.graph_api.get_connections("me", "friends")
  end

  def mutual_friends
    self.graph_api.get_connections("me", "mutualfriends/1026310006")
  end

  def friends_who_installed_app
    friends = self.graph_api.graph_call("/#{self.uid}/friends?fields=name,installed")
    friends.map{|friend| friend["id"]}
  end

  def get_places (name, country)
    places =  graph_api.graph_call("/search?q=skiing&type=place&center=43.4,-80.54&distance=50000&limit=20")
    #return places.reject {|place| place["location"]["country"] != country}
    return places
  end

  def my(request)
    self.graph_api.get_connections("me",request)
  end

  def graph(command)
    self.graph_api.graph_call(command)
  end

  def create_event(name, date, invitees_uids, privacy_type = "CLOSED")
    event = self.graph_api.graph_call("/me/events",{
      name: name, 
      start_time: date, # sample date: "2014-02-17"
      privacy_type: privacy_type,
      access_token: self.oauth_token}, "POST")

    invite_to_event(event["id"], invitees_uids)

    event
  end

  def invite_to_event(event_id, invitees_uids)
    self.graph_api.graph_call("/#{event_id}/invited",{
      users: invitees_uids,
      access_token: self.oauth_token}, "POST")
  end

  def profile_pic
    return "http://graph.facebook.com/#{self.uid}/picture"
  end
end
