class EventUsersController < ApplicationController
  before_filter :login_required

  def participate
    @event = Event.find(params[:id])
    current_user.participate(@event)
    redirect_to @event
  end

end