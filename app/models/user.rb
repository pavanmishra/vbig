class User < ActiveRecord::Base
  
  has_many :badge_users
  has_many :badges, :through => :badge_users
  
  acts_as_mappable :auto_geocode => true
  acts_as_taggable_on :causes, :skills
  
  validates_presence_of :first_name, :last_name, :address
  WithinDistance = 10
  
  def award(badge)
    badges << badge.first
  end

  def awarded?(badge)
    badges.count(:conditions => { :type => badge }) > 0
  end
    
end
