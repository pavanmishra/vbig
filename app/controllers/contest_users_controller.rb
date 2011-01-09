class ContestUsersController < ApplicationController
  before_filter :login_required
  def create
    contest = Contest.find params[:id]
    contest_user = ContestUser.new :contest => contest, :user => current_user
    Activity.create :subject => contest, :user => current_user, :action => 'participate-contest', :contest_id => params[:id]
    flash[:notice] = contest_user.save ? 'You are now participating in this contest.' : 'There was an error in making you participate the contest.'
    redirect_to contest
  end
  
  def new
    contest = Contest.find params[:id]
    render :layout => false
  end
end