class UserMailer < ActionMailer::Base
  

  def welcome_facebook_user(user, sent_at = Time.now)
    subject    'WelCome to Volunteer Big'
    recipients user.email
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi, This is ghost at Volunteer Big.'
  end

end
