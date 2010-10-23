class PledgesController < ApplicationController
  
  layout  'organizations'
  before_filter :login_required
  
  def new
    @pledge = Pledge.new
    render :layout => false
  end
  
  def create
    @pledge = Pledge.new params[:pledge]
    @pledge.user  = current_user
    if @pledge.save
      flash[:notice] = 'Your pledge has been recieved. Go ahead and take other interesting pledges.'
      redirect_to :action => :new
    else
      flash[:error] = 'Invalid Pledge'
      render  :action => :new
    end
  end
  
  def index
    @pledges = current_user.pledges
  end
end