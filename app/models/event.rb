class Event < ActiveRecord::Base
  belongs_to  :organization
  has_many  :event_users
  has_many  :users, :through => :event_users
  named_scope :featured, :conditions => {:featured => true}
  
  acts_as_mappable :auto_geocode => true
  validates_presence_of :title, :description, :address
  acts_as_taggable_on :causes, :skills
  
  # paperclip image attachment
  has_attached_file :image, :styles => {
        :thumb=> "100x100#",
        :small  => "150x150>",
        :medium => "300x300>",
        :large =>   "400x400>"
  }
  
  FeaturedCauses = ['Environment', 'Poverty']
  FeaturedSkills = ['Social Media', 'Writing']
end
