class PersonalInvitation < Invitation
  
  validates_presence_of :email
  
  def self.invite(emails, by, event)
    emails.each do |email|
      invite = self.create :code => self.random_code, :email => email, :by => by, :event => event
      InvitationMailer.deliver_invite invite
    end
  end
end