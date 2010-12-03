class ReceivedController < ApplicationController
  layout 'events'  
  before_filter :login_required
  
  def index
    conditions =  params[:filter].eql?('unread') ? {:read => false, :read => nil} : {}
    @messages = current_user.received_messages.paginate :page => params[:page], :order => 'created_at DESC', :conditions => conditions
  end

  def show
    @message = current_user.received_messages.find(params[:id])
    @message.update_attribute :read, true unless @message.read?
  end

end
