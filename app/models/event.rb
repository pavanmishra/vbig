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
  
  def get_or_create_invite_links_for(user)
    invitations = Invitation.find(:all, :conditions => {:event_id => self, :user => user, :type => ['TwitterInvitation', 'FacebookInvitation']})
    invitations = Invitation.create_social_invites_for_event_user(self, user) if invitations.blank?
    return invitations
  end
end
