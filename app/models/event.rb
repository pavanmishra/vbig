class Event < ActiveRecord::Base
  belongs_to  :organization
  has_many  :event_users
  has_many  :users, :through => :event_users
  belongs_to  :user
  named_scope :featured, :conditions => {:featured => true}
  
  acts_as_mappable :auto_geocode => true
  acts_as_taggable_on :causes, :skills
  has_threaded_comments
  
  validates_presence_of :title, :description, :address
  validate  :must_be_either_ongoing_or_dated
  
  # paperclip image attachment
  has_attached_file :image, :styles => {
        :thumb=> "100x100#",
        :small  => "150x150>",
        :medium => "300x300>",
        :large =>   "400x400>"
  }
  
  def feature!
    self.update_attribute :featured, true
  end
  
  def related_events
    begin
      tagged_events_scope = Event.tagged_with(self.causes + self.skills)
      tagged_events_scope.blank? ? [] : tagged_events_scope.find(:all, :conditions => "events.id != #{self.id}", :origin => self.address, :within => 10)
    rescue Geokit::Geocoders::GeocodeError
      []
    end
  end
  
  def get_or_create_invite_links_for(user)
    invitations = Invitation.find(:all, :conditions => {:event_id => self, :user_id => user, :type => ['TwitterInvitation', 'FacebookInvitation']})
    invitations = Invitation.create_social_invites_for_event_user(self, user) if invitations.blank?
    return invitations
  end
  
  def self.find_matching_events_to(new_event)
    matching_condition = "match(title) against ('#{new_event.title}')"
    matching_condition += " and date(from_date) = date(#{new_event.from_date})" unless new_event.from_date.nil?
    matching_condition += " and date(to) = date(#{new_event.to})" unless new_event.to.nil?
    self.find(:all, :conditions => matching_condition, :limit => 25, :origin => new_event.address, :within => 5)
  end
  
  # used by the activity logging system
  def name 
    self.title
  end
  protected
  
  def must_be_either_ongoing_or_dated
    errors.add_to_base("Event must either be ongoing or have fixed time interval") unless self.ongoing or (self.from_date and self.to)
  end
end
