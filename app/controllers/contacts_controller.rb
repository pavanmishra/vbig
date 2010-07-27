class ContactsController < ApplicationController
  require 'bitly'
  layout 'events'
  def plaxo_cb
    render :layout => false
  end

  def new_import
    
  end
  
  def invite_to_event
    @event = Event.find params[:event_id]
    @invites = @event.get_or_create_invite_links_for(current_user) if logged_in?
  end
  
  def import
    # find_by_id does not raise an exception, which is good for this scenario
    event = Event.find_by_id(params[:event_id])
    PersonalInvitation.invite(params[:recipients].split(',').collect {|recipient| recipient.split('<').last.sub('>', '') }, current_user, event)
    redirect_to params.key?(:event_id) ? {:action => :invite_to_event, :event_id => params[:event_id] } : {:action => :new_import}
  end
  
  def join_by_invitation
    invite = Invitation.find_by_code params[:invite_code]
    if invite
      cookies[:invite_code] = params[:invite_code]   
    else
      flash[:notice] = 'Looks like you clicked an expired link. No issues, go ahead you can still VolunteerBig'
    end
    redirect_to root_path
  end

end
