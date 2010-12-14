class PersonalInvitation < Invitation
  
  validates_presence_of :email
  
  def self.invite(emails, by, contest = nil, invitable = nil)
    emails.each do |email|
      invite = self.create :code => self.random_code, :email => email, :user => by, :invitable => invitable, :contest => contest
      InvitationMailer.deliver_invite invite
    end
  end
  
  def self.invite_for_contest emails, user, contest, invitable_id = nil, invitable_type = nil
    emails.each do |email|
      invite = self.create :code => self.random_code, :email => email, :user => user, :contest => contest, :invitable_id => invitable_id, :invitable_type => invitable_type
      InvitationMailer.deliver_contest_invite invite
    end
  end
end