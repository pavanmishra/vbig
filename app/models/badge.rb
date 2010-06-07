class Badge < ActiveRecord::Base
  has_many :badge_users
  has_many :users, :through => :badge_users
  
end
