class ContactsController < ApplicationController
  layout 'events'
  def plaxo_cb
    render :layout => false
  end

  def new_import
    
  end
  
  def import
    Invitation.invite(params[:recipients].split(',').collect {|recipient| recipient.split('<').last.sub('>', '') }, current_user)
    render :action => :new_import
  end
  
  def join_by_invitation
    invite = Invitation.find_by_code params[:invite_code]
    if invite
      cookies[:invite_code] = {:value => params[:invite_code], :expires => 1.hour.from_now}
      redirect_to :controller => :users, :action => :new
    else
      flash[:notice] = 'Looks like you clicked an expired link. No issues, go ahead you can still VolunteerBig'
    end
  end

end
