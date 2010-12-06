class FacebookSessionsController < ApplicationController
  before_filter :set_fb_info, :only => :create
  include AuthenticatedSystem
  def create
    if verify_fb_cookie_signature
      logger.debug "verified fb cookie signature"
      user_info = get_user_info
      user = User.find_facebook_user(user_info)
      unless user
        user = User.create_facebook_user(user_info) 
        user_signup = true
        if cookies[:invite_code]
          Invitation.update_invite(cookies[:invite_code], user.email) 
          if cookies[:invite_event].nil?  
              cookies.delete(:invite_code)
          else
              invitation = Invitation.find_by_code(cookies[:invite_code])
              PointLog.create :event_id => invitation.event_id, :user_id => invitation.user_id, :point => invitation.event.contests.first.invite_points rescue nil
          end 
        end
      end
      redirect_path = cookies[:invite_event].nil? ? user_path(user) : event_path(Invitation.find_by_code(cookies[:invite_code]).event_id)      
      logout_keeping_session!
      self.current_user = user
      logger.debug "redirecting to join_with_facebook_account_and_email to create a new user"
      user_signup ? redirect_to(:controller => :users, :action => :set_address_and_preferences) : redirect_to(redirect_path)
    else
      logger.debug "couldn't verify the fb cookies; redirecting back - user must have clicked on don't allow"
      flash[:notice] = 'TO USE VOLUNTEERBIG, YOU MUST ALLOW ACCESS TO YOUR FACEBOOK ACCOUNT'
      redirect_to :back
    end
  end
  
  def signup
    render :layout => false
  end
  
  private
   
  def set_fb_info
    @fb_info = MiniFB.parse_cookie_information('131541183544567', cookies)
  end
    
  def verify_fb_cookie_signature
    MiniFB.verify_cookie_signature('131541183544567', '563b67ef41a8570e12d66e3f1a16cc58', cookies)
  end
    
  def get_user_info
    MiniFB.call('131541183544567', '563b67ef41a8570e12d66e3f1a16cc58', "Users.getInfo", "session_key"=>@fb_info['session_key'], "uids"=>@fb_info['uid'], "fields"=>"first_name,last_name,email,middle_name,name,locale,current_location,affiliations,pic_square,profile_url,sex").first
  end
  
end