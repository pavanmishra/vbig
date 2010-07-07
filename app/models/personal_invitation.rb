class PersonalInvitation < Invitation
  
  validates_presence_of :email
  def self.invite( emails, by )
    emails.each do |email|
      invite = self.create :code => self.random_code, :email => email, :by => by
      InvitationMailer.deliver_invite invite
    end
  end
end