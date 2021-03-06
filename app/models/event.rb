class Event < ActiveRecord::Base
  belongs_to  :organization
  has_many  :event_users
  has_many  :users, :through => :event_users
  belongs_to  :user
  has_many  :event_images,  :dependent => :destroy
  has_many  :activities, :as => :subject
  has_many  :editorships, :as => :editable
  has_many  :editors, :through => :editorships, :class_name => 'User'
  has_many  :contest_events
  has_many  :contests, :through => :contest_events
  named_scope :featured, :conditions => {:featured => true}
  
  accepts_nested_attributes_for :event_images, :reject_if => lambda{|t| t['event_image'].nil?}
  acts_as_mappable :auto_geocode => true
  acts_as_taggable_on :causes, :skills
  has_threaded_comments
  
  validates_presence_of :title, :description, :address
  validate  :must_be_either_ongoing_or_dated
  
  # paperclip image attachment
  has_attached_file :image, :path => ':rails_root/public/system/images/events/:attachment/:id/:style/:filename', 
        :url => '/system/images/events/:attachment/:id/:style/:filename',
        :styles => {
          :small_thumbnail => "75x79#",
          :smaller_thumbnail => "60x60#",
          :thumb=> "100x100#",
          :small  => "150x150>",
          :medium => "200x200#",
          :large =>   "400x400>"
        }
  cattr_reader :per_page
   @@per_page = 10
  
  def feature!
    self.update_attribute :featured, !self.featured
  end
  
  def closed?
    self.status.eql?('completed')
  end
  
  def complete!
    self.update_attribute :status,  'completed'
    # send out emails to participating users about the completion of the event and the can provide us the valuable feedback
    # self.users
  end
  
  def completed?
    self.status.eql?('completed')
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
    invitations = Invitation.create_social_invites(user, nil, self)
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
