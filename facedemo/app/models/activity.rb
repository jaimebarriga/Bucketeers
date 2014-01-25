class Activity < ActiveRecord::Base
  belongs_to :tag
  belongs_to :user
  attr_accessible :desc, :state

  
end
