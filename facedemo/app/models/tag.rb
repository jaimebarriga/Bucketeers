class Tag < ActiveRecord::Base
  has_many :activities
  has_many :users, through: :activities
  attr_accessible :name, :score

end
