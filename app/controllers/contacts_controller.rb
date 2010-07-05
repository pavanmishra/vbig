class ContactsController < ApplicationController
  layout 'events'
  def plaxo_cb
    render :layout => false
  end

  def new_import
    
  end
  
  def import
    raise params[:recipients].split(',').collect {|recipient| recipient.split('<').last.sub('>', '') }.inspect
    
  end
  
  def join_by_invitation
    invite = Invitation.find_by_code params[:inivite_code]
    if invite
      cookies[:invitation_code] = {:value => params[:invitation_code], :expires => 1.hour.from_now}
    else
      flash[:notice] = 'Looks like you clicked an expired link. No issues, go ahead you can still VolunteerBig'
    end
  end

end
