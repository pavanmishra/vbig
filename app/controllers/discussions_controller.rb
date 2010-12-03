class DiscussionsController < ApplicationController
  
  layout  'events'
  before_filter :login_required,  :only => [:new, :create]
  
  def index
   @discussions = Discussion.paginate(:all, :limit => 25, :page => params[:page])
   @recent_discussions = Discussion.find(:all, :limit => 5, :order => 'created_at DESC')
  end
  
  def new
    @discussion = Discussion.new
  end
  
  def create
    process_params_for_tags 'discussion', 'cause' 
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
    @new_comment = @discussion.comments.new(:name => current_user.name, :email => current_user.email, :user_id => current_user.id) if logged_in?
  end
  
end