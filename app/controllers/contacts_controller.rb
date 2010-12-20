class ContactsController < ApplicationController
  require 'bitly'
  layout 'events'
  before_filter :login_required, :except => [:participate_event_by_invitation, :join_by_invitation]
  
  def plaxo_cb
    render :layout => false
  end

  def new_import
    @invite_event = Event.find(cookies[:invite_event]) unless cookies[:invite_event].nil?
    render :layout => false
  end
  
  def invite_to_event
    @event = Event.find params[:id]
    render  :layout => false
  end
  
  def share_event
    @event = Event.find(params[:id])
    @invites = @event.get_or_create_invite_links_for(current_user) if logged_in?
    render  :layout => false
  end
  
  def import
    # find_by_id does not raise an exception, which is good for this scenario
    event = Event.find_by_id(params[:id])
    PersonalInvitation.invite(params[:recipients].split(',').collect {|recipient| recipient.split('<').last.sub('>', '') }, current_user, nil, event)
    flash[:notice] = 'You have succesfully sent your invite'
    redirect_to params.key?(:id) ? event : root_path
  end
  
  def import_for_contest
    contest = Contest.find(params[:id])
    PersonalInvitation.invite_for_contest(params[:recipients].split(',').collect {|recipient| recipient.split('<').last.sub('>', '') }, current_user, contest, params[:invitable_id], params[:invitable_type])
    flash[:notice] = 'Your invite has been successfuly sent.'
    redirect_to contest
  end
  
  def participate_event_by_invitation
    invite = Invitation.find_by_code params[:invite_code]
    if invite
      if logged_in?
        flash[:notice] = 'You have been invited to participate this event, please click on "Participate" to continue.'
        redirect_to invite.invitable
      else
        flash[:notice] = 'Please signup, before participating in the invited event.'
        cookies[:invite_code] = params[:invite_code]
        cookies[:invite_event] = invite.event_id
        redirect_to root_path
      end
    else
      flash[:notice] = 'Thats not a valid link.'
      redirect_to root_path
    end
  end
  
  def join_by_invitation
    invite = Invitation.find_by_code params[:invite_code]
    if invite
      cookies[:invite_code] = params[:invite_code] 
      if invite.contest
        unless logged_in?
        flash[:notice] = "Please login/signup using button at the top. To proceed with the contest"
        redirect_to(invite.contest) and return
        else
          redirect_to(vote_organization_on_contest_path(:id => invite.contest_id, :code => invite.code)) and return 
        end
      end
    else
      flash[:notice] = 'Looks like you clicked an expired link. No issues, go ahead you can still VolunteerBig'
    end
    redirect_to  root_path
  end

end
