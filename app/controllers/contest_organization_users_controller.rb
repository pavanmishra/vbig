class ContestOrganizationUsersController < ApplicationController
  before_filter :login_required
  
  def vote
    contest_vote = ContestOrganizationUser.first :conditions => {:contest_id => params[:contest_id], :organization_id => params[:organization_id], :user_id => current_user.id}
    if contest_vote
      flash[:notice] = 'YOu have already voted for this organization in this contest'
    else
      flash[:notice] = 'Your vote has been accepted'          
      contest_vote =  ContestOrganizationUser.create :contest_id => params[:contest_id], :organization_id => params[:organization_id], :user_id => current_user.id
      # set the vote activity
      Activity.create :user => current_user, :subject => contest_vote.organization, :contest_id => params[:contest_id], :action => 'organization_vote', :points => 10
    end
    redirect_to contest_vote.contest
  end
  
  def new
    
  end
  
end