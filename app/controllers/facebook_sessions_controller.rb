class FacebookSessionsController < ApplicationController
  before_filter :set_fb_info
  include AuthenticatedSystem
  def create
    if verify_fb_cookie_signature
      logger.debug "verified fb cookie signature"

      user_info = get_user_info
      user = User.find_facebook_user(user_info)
      unless user
        user = User.create_facebook_user(user_info) 
        Invitation.update_invite(cookies[:invite_code], user_info[:email]) and cookies.delete(:invite_code) if cookies[:invite_code]
      end
      logout_keeping_session!
      self.current_user = user
      logger.debug "redirecting to join_with_facebook_account_and_email to create a new user"
      flash[:notice] = user_info.inspect 
      
      redirect_to '/'
    else
      logger.debug "couldn't verify the fb cookies; redirecting back - user must have clicked on don't allow"
      flash[:notice] = 'Could not verify the cookie information'
      redirect_to '/'
    end
  end
  
  private
   
  def set_fb_info
    @fb_info = MiniFB.parse_cookie_information('131541183544567', cookies)
  end
    
  def verify_fb_cookie_signature
    MiniFB.verify_cookie_signature('131541183544567', '563b67ef41a8570e12d66e3f1a16cc58', cookies)
  end
    
  def get_user_info
    MiniFB.call('131541183544567', '563b67ef41a8570e12d66e3f1a16cc58', "Users.getInfo", "session_key"=>@fb_info['session_key'], "uids"=>@fb_info['uid'], "fields"=>"first_name,last_name,email").first
  end
  
end