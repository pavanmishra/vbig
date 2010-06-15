class Event < ActiveRecord::Base

  acts_as_mappable :auto_geocode => true
  validates_presence_of :title, :description, :address
  acts_as_taggable_on :causes, :skills
  #attr_accessor :cause_list, :skill_set
  
  belongs_to  :organization
  
end
