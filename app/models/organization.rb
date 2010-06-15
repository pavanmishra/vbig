class Organization < ActiveRecord::Base
  has_many  :events
  
  acts_as_taggable_on :causes, :skills
  
  # paperclip image attachment
  has_attached_file :image, :styles => {
        :thumb=> "100x100#",
        :small  => "150x150>",
        :medium => "300x300>",
        :large =>   "400x400>"
  }
  
end
