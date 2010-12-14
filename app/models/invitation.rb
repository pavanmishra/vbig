class Invitation < ActiveRecord::Base
  belongs_to  :invitable, :polymorphic => true
  belongs_to  :contest  
  belongs_to :user
  belongs_to :event

  validates_presence_of :code
    
  def self.update_invite(code, email)
    invite = self.find_by_code(code)
    invite.user.get_points_for(:invite_accepted)
    invite.update_attribute(:used, true)
  end
  
  def self.random_code
    o =  [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten;  
    random_string  =  (0..30).map{ o[rand(o.length)]  }.join;
    existing_code = self.find_by_code random_string
    # this is recursive call to find a code not used to till now if the duplicate code has been generated
    existing_code ? random_code : random_string
  end
  # invite can be sent from within the application
  def self.create_social_invites(user, contest = nil, invitable = nil)
    contest_id = contest.nil? ? nil : contest.id
    invitable_id, invitable_type = invitable.nil? ? [nil, nil] : invitable.id, invitable.class.to_s
    social_invites = [self.find( :first, :conditions => {:contest_id => contest_id, :type => 'TwitterInvitation', :invitable_id => invitable_id, :invitable_type => invitable_type}), self.find( :first, :conditions => {:contest_id => contest_id, :type => 'FacebookInvitation', :invitable_id => invitable_id, :invitable_type => invitable_type})]
    if social_invites.all?{|invite| invite.nil?}
      social_invites = []
      social_invites << TwitterInvitation.create( :code => self.random_code, :user => user, :invitable => invitable, :contest => contest)
      social_invites << FacebookInvitation.create( :code => self.random_code, :user => user, :invitable => invitable, :contest => contest      )
    end
    return social_invites
  end
  
  def self.create_social_invites_for_invitable_components(user, contest = nil, invitable_type = nil, invitable_id = nil)
    invitable = case invitable_type
    when 'organization'
      Organization.find(invitable_id)
    end
    self.create_social_invites(user, contest, invitable)
  end
  
  
  def self.create_social_invites_for_event_user(event, user)
    twitter_invite = TwitterInvitation.create :code => self.random_code, :user => user, :event => event
    facebook_invite = FacebookInvitation.create :code => self.random_code, :user => user, :event => event
    return [twitter_invite, facebook_invite]
  end
  
end