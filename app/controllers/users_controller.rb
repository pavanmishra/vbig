class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  before_filter :login_required, :only => [:edit, :profile]
  # GET /users
  # GET /users.xml
  def index
    params[:near] = params[:near].blank? ? 'unknown island' : params[:near]
    @users = !params[:search].blank? ? User.tagged_with(params[:search].split(','), :any => true).find(:all, :origin=> params[:near], :within => 25) : User.find(:all, :origin => params[:near], :within => 25)
    @users = User.all if @users.blank?
    @title = 'People'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @title = @user.name
    @recommended_events = []#Event.tagged_with(@user.causes).all(:origin => [@user.lat, @user.lng], :within => User::WithinDistance)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  def profile
    @user = current_user
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @title = 'New User'
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save

        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    params[:user][:skill_list] = params[:skills] if params[:skills]
    params[:user][:cause_list] = params[:causes] if params[:causes]
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_address_and_preferences
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if  @user.proper_address? 
      redirect_to(signup_step_two_path)
    else 
      flash[:notice] = 'Its important that you complete this step, by providing your complete address'
      render(:action => :set_address_and_preferences, :layout => 'signup')
    end
  end
  
  def update_tags
    # code duplication need to fix
    @user = current_user
    #params[:user] = {}
    params[:user][:skill_list] = params[:skills]
    params[:user][:cause_list] = params[:causes]
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'

        format.html { 
          unless cookies[:invite_event]
            redirect_to(:controller => :contacts, :action => :new_import) 
          else
            redirect_to(event_path(cookies[:invite_event]))
          end
          }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
    
  end
  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    Invitation.update_invite(cookies[:invite_code], @user.email) and cookies.delete(:invite_code) if cookies[:invite_code]
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def signup_step_two
    @user = current_user
    render :layout => 'signup'
  end
  
  def set_address_and_preferences
    @user = current_user
    render :layout => 'signup'
  end
  
  def leaders 
    @users = User.all :order => 'points desc'
    render :action => :index
  end
end
