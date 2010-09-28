class DiscussionsController < ApplicationController
  
  layout  'events'
  before_filter :login_required,  :only => [:new, :create]
  
  def index
    @recent_discussions = @popular_discussions = @discussions = Discussion.find(:all, :limit => 25)
  end
  
  def new
    @discussion = Discussion.new
  end
  
  def create
    @discussion = Discussion.new(params[:discussion])
    @discussion.user = current_user
    if @discussion.save
      flash[:notice] = 'A discussion has been created.'
      redirect_to @discussion
    else
      render  :action => :new
    end
  end
  
  def show
    @discussion = Discussion.find(params[:id])
    @new_comment = @discussion.comments.new(:name => current_user.name, :email => current_user.email) if logged_in?
  end
  
end