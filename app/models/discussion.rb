class Discussion < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :organization
  has_threaded_comments
  
  validates_presence_of :title, :description, :user_id, :address
  acts_as_mappable :auto_geocode => true
  acts_as_taggable_on :causes
  
end