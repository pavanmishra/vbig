class InvitationMailer < ActionMailer::Base
  

  def invite(invite, sent_at = Time.now)
    subject    'Invitation to join VolunteerBig'
    recipients invite.email
    from       invite.user.email
    sent_on    sent_at
    
    body       :invite => invite
  end

end
