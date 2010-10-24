class SentController < ApplicationController
  layout 'events'
  before_filter :login_required
  def index
    @messages = current_user.sent_messages.paginate :all, :order => "created_at DESC", :page => params[:page]
  end

  def show
    @message = current_user.sent_messages.find(params[:id])
  end

  def new
    @message = current_user.sent_messages.build
  end
  
  def new_to_user
    @message = current_user.sent_messages.build
    render :layout => false
  end
  
  def create
    @message = current_user.sent_messages.build(params[:message])
    
    if @message.save
      flash[:notice] = "Message sent."
      redirect_to :back
    else
      render :action => "new"
    end
  end
  
end
