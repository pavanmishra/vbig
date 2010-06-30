class FacebookSessionsController < ApplicationController
  
  def connect_oauth
    if verify_fb_cookie_signature
      logger.debug "verified fb cookie signature"
      user_info = get_user_info
     
      logger.debug "redirecting to join_with_facebook_account_and_email to create a new user"
      flash[:notice] = 'Messed up' 
      redirect_to '/'
    else
      logger.debug "couldn't verify the fb cookies; redirecting back - user must have clicked on don't allow"
      redirect_to :back
    end
  end
  
  private
   
  def set_fb_info
    @fb_info = MiniFB.parse_cookie_information(Facebooker.facebooker_config['app_id'], cookies)
  end
    
  def verify_fb_cookie_signature
    MiniFB.verify_cookie_signature(Facebooker.facebooker_config['app_id'], Facebooker.facebooker_config['secret_key'], cookies)
  end
    
  def get_user_info
    MiniFB.call(Facebooker.facebooker_config['app_id'], Facebooker.facebooker_config['secret_key'], "Users.getInfo", "session_key"=>@fb_info['session_key'], "uids"=>@fb_info['uid'], "fields"=>"email").first
  end
  
end