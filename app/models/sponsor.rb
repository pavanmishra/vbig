class Sponsor < ActiveRecord::Base
  has_many  :contest_sponsors
  has_many  :contests, :through => :contest_sponsors
  has_attached_file :image, :path => ':rails_root/public/system/images/sponsors/:attachment/:id/:style/:filename', 
        :url => '/system/images/sponsors/:attachment/:id/:style/:filename',
        :styles => {
          :small_thumbnail => "75x79#",
          :smaller_thumbnail => "60x60#",
          :thumb=> "100x100#",
          :small  => "150x150>",
          :medium => "200x200#",
          :large =>   "400x400>"
        }
  
end
