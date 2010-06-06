class User < ActiveRecord::Base

  acts_as_mappable :auto_geocode => true
  acts_as_taggable_on :causes, :skills
  
  validates_presence_of :first_name, :last_name, :address
    
end
