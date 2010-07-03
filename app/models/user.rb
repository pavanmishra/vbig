require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  has_many :badge_users
  has_many :badges, :through => :badge_users
  has_many :organization_users
  has_many :organizations, :through => :organization_users
  has_many  :event_users
  has_many  :events, :through => :event_users
  has_many  :sent_messages, :class_name => 'Message', :foreign_key => :author_id
  has_many  :received_messages, :class_name => 'MessageCopy', :foreign_key  => :recipient_id
  
  acts_as_mappable :auto_geocode => true
  acts_as_taggable_on :causes, :skills
  
  validates_presence_of :first_name, :last_name#, :address
  WithinDistance = 10

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

#  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
#  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  # paperclip image attachment
  has_attached_file :image, :styles => {
        :thumb=> "100x100#",
        :small  => "150x150>",
        :medium => "300x300>",
        :large =>   "400x400>"
  }
  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :first_name, :last_name, :password, :password_confirmation, :address, :facebook_user_id, :facebook_access_token



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  def award(badge)
    badges << badge.first
  end

  def awarded?(badge)
    badges.count(:conditions => { :type => badge }) > 0
  end
    
  def name
    "#{self.first_name} #{self.last_name}"
  end

  def helping?(organization)
    self.organizations.include?(organization)
  end
  
  def help(organization)
    self.organizations << organization
  end
  
  def participating?(event)
    self.events.include?(event)
  end
  
  def participate(event)
    self.events << event
  end
  
  def self.find_facebook_user(user_info)
    self.find_by_facebook_user_id(user_info['uid'])
  end
  
  def self.create_facebook_user(user_info)
    o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten;  
    random_string  =  (0..16).map{ o[rand(o.length)]  }.join;
    # do remember the generic U.S.A is given here for the hack,
    # need to use facebook api to get the address or ask user himself.
    user = User.create :email => user_info['email'], :facebook_user_id => user_info['uid'], :login => user_info['email'], :first_name => user_info['first_name'], :last_name => user_info['last_name'], :address => 'U.S.A',  :password => random_string, :password_confirmation => random_string
    # this is also a hook to send out mailer for user who signed up from facebook
    UserMailer.deliver_welcome_facebook_user user
  end
  
  protected
    


end
