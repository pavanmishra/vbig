class EventUsersController < ApplicationController
  before_filter :login_required
  layout  'events'
  def participate
    @event = Event.find(params[:id])
    current_user.participate(@event) unless current_user.participating?(@event)
    redirect_to @event
  end

  def new
    @event_user = EventUser.find(params[:id])
  end
  
  def update
    @event_user = EventUser.find params[:id]
    @event_user.update_attributes(params[:event_user])
    if @event_user.save
      flash[:notice] = 'Your feedback has been recieved'
#      redirect_to 
    else
      
    end
  end
  
end