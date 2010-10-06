class EventImage < ActiveRecord::Base
  belongs_to  :event
  # paperclip image attachment
  has_attached_file :photo, :path => ':rails_root/public/system/images/event_photos/:attachment/:id/:style/:filename', :styles => {
        :thumb=> "100x100#",
        :small  => "150x150>",
        :medium => "200x200>",
        :large =>   "400x400>"
  }
end
