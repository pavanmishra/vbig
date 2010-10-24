class ReceivedController < ApplicationController
  layout 'events'  
  before_filter :login_required
  
  def index
    @messages = current_user.received_messages.paginate :page => params[:page]
  end

  def show
    @message = current_user.received_messages.find(params[:id])
  end

end
