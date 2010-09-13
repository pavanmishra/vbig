class Organization < ActiveRecord::Base
  has_many  :events
  belongs_to  :user
  has_many :organization_users
  has_many  :users, :through => :organization_users

  acts_as_taggable_on :causes, :skills
  
  # paperclip image attachment
  has_attached_file :image, :styles => {
        :thumb=> "100x100#",
        :small  => "150x150>",
        :medium => "300x300>",
        :large =>   "400x400>"
  }
  
  def to_s
    name 
  end
end
