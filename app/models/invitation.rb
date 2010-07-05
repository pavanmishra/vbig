class Invitation < ActiveRecord::Base
  
  belongs_to :by, :class_name => 'User'
  
  def self.invite( emails, by )
    emails.each do |email|
      invite = Invitation.create :code => self.random_code, :email => email, :by => by
      InvitationMailer.deliver_invite invite
    end
  end
  
  def self.update_invite(code, email)
    invite = self.find_by_code_and_email(code, email)
    invite.by.get_points_for(:invite_accepted)
    invite.update_attributes(:used, true)
  end
  
  def self.random_code
    o =  [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten;  
    random_string  =  (0..30).map{ o[rand(o.length)]  }.join;
    existing_code = self.find_by_code random_string
    # this is recursive call to find a code not used to till now if the duplicate code has been generated
    existing_code ? random_code : random_string
  end
  
end