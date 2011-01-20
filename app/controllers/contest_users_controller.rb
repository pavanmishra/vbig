class ContestUsersController < ApplicationController
  before_filter :login_required

  def create
    contest = Contest.find params[:id]
    contest_user = ContestUser.new :contest => contest, :user => current_user
    Activity.create :subject => contest, :user => current_user, :action => 'participate-contest', :contest_id => params[:id]
    flash[:notice] = contest_user.save ? 'You are now participating in this contest.' : 'There was an error in making you participate the contest.'
    unless session[:vote_or_recruit]
      redirect_to contest
    else
      vote_or_recruit = session.delete(:vote_or_recruit)
      target = session.delete(:target)
      if vote_or_recruit.eql?('vote')
        render  :layout => false, :partial => 'prompt_organization_vote', :locals => {:contest => contest, :organization => Organization.find(target)}
      else
        @social_invites = Invitation.create_social_invites_for_invitable_components(current_user, contest, 'organization', target)
        render 'contests/invite_to_contest', :layout => false
      end
    end
  end
  
  def new
    session[:vote_or_recruit] = params[:vote_or_recruit] if params[:vote_or_recruit]
    session[:target] = params[:target] if params[:vote_or_recruit]
    contest = Contest.find params[:id]
    render :layout => false
  end

end