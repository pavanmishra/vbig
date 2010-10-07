class Organization < ActiveRecord::Base
  has_many  :events
  belongs_to  :user
  has_many :organization_users
  has_many  :users, :through => :organization_users
  has_many  :editorships, :as => :editable
  
  acts_as_mappable :auto_geocode => true
  acts_as_taggable_on :causes, :skills
  has_threaded_comments
  
  # paperclip image attachment
  has_attached_file :image, :path => ':rails_root/public/system/images/organizations/:attachment/:id/:style/:filename', :styles => {
        :thumb=> "100x100#",
        :small  => "150x150>",
        :medium => "300x300>",
        :large =>   "400x400>"
  }
  cattr_reader :per_page
  @@per_page = 10
  
  def to_s
    name 
  end
end
