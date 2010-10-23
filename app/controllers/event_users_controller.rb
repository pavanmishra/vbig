class EventUsersController < ApplicationController
  before_filter :login_required
  layout  'events'
  # need to make this secure
  def participate
    @event = Event.find(params[:id])
    flash[:notice] = current_user.participating?(@event) ? 'You have denied to participate this event' : 'You are now participating this event'
    current_user.participating?(@event) ? current_user.deny_participation(@event) : current_user.participate(@event) 
    redirect_to @event
  end

  def new
    @event_user = EventUser.find(params[:id])
    render :layout => false
  end
  
  def update
    @event_user = EventUser.find params[:id]
    @event_user.update_attributes(params[:event_user])
    if @event_user.save
      flash[:notice] = 'Your feedback has been recieved'
      redirect_to @event_user.event
    else
      render :action => :new
    end
  end
  
end