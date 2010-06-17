class ReceivedController < ApplicationController
  
  before_filter :login_required
  
  def index
    @messages = current_user.received_messages
  end

  def show
    @message = current_user.received_messages.find(params[:id])
  end

end
