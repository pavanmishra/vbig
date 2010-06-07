class Badge < ActiveRecord::Base
  #has_many :badge_users
  belongs_to :user#, :through => :badge_users
  
end
