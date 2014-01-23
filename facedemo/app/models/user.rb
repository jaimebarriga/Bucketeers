require 'net/http'
require 'net/https'

class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid

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

  def super_token # from developers.facebook.com/tools/explorer
    "CAACEdEose0cBAIAIhaMGCZC0B9yccbHE9JT4w8AZBZC7KFG4nlsRsBJdHdZBOTRP4pWpF45lENlo0kIfFZAhYpiNPQcdQ0brafNEZCZBortiqQCQOEZCUxxYtlZCRj09OLl5KX15hXNqZCqYchUh0fbauCkGKBOydVYibBrCSWHTkcaWpGQvwwdUE2XgprdJw1ItKAZBsA9bZCz8iAZDZD"
  end

  def graph_api
    token = self.super_token
    # token = self.oauth_token
    Koala::Facebook::API.new(token)
  end

  def profile
    self.graph_api.get_object('me')
  end

  def friends
    @friends = self.graph_api.get_connections("me", "friends")
  end

  def mutual_friends
    self.graph_api.get_connections("me", "mutualfriends/1026310006")
  end

  def my(request)
    self.graph_api.get_connections("me",request)
  end


  def create_event(name, invitees)
    event = self.graph_api.graph_call("/me/events",{
      name: name, 
      start_time:   "2014-02-17", # sample date 
      privacy_type: "CLOSED",
      access_token: self.super_token}, "POST")

    invite_to_event(event["id"], invitees)

    event
  end

  def invite_to_event(event_id, invitees)
    self.graph_api.graph_call("/#{event_id}/invited",{
      users: invitees.map{|invitee| invitee.uid},
      access_token: self.super_token}, "POST")
  end

end
