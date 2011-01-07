class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  before_filter :admin_required, :only => [:feature, :new, :create]
  before_filter :login_required,  :only => [:new, :create, :suggested]

  def index
    @title = 'Recent Events'
    params[:near] = params[:near].blank? ? 'unknown island' : params[:near]
    #@events = !params[:search].blank? ? Event.tagged_with(params[:search].split(','), :any => true).find(:all, :origin=> params[:near], :within => 25) : Event.find(:all, :origin => params[:near], :within => 25)
    @events = params[:search].blank? ? Event.paginate(:page => params[:page]) : Event.paginate(:page => params[:page], :origin=> params[:near], :within => 25, :conditions => "title like '%#{params[:search]}%'")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  def event_comments
    @event = Event.find(params[:id])
    @new_comment = @event.comments.new(:name => current_user.name, :email => current_user.email) if logged_in?
  end
  
  def event_photos
    @event = Event.find(params[:id])
    @event_image = EventImage.new
  end
  
  def create_event_image
    @event = Event.find(params[:id])
    @event_image = @event.event_images.create params[:event_image]
    #@event_image.save
    render :action => :event_photos
  end
  
  def event_activities
    @event = Event.find(params[:id])
  end
  
  def home
    unless logged_in?
      @events = Event.featured.paginate(:all, :limit => 5, :order => 'events.from_date', :page => params[:page])
      @title = 'Featured Events'
      @badges = Badge.all(:limit => 9)
      @users = User.all(:limit => 10, :order => 'created_at desc')
      render :layout => 'home'
    else
      @user = current_user
      render :template => 'users/home'
    end
  end
  
  def suggested
    @title = 'suggested participation'
    @events = current_user.suggested_events(params[:page])
    @events = Event.featured( :limit => 5) if @events.empty?
    render :template => 'events/index.html.erb'
  end
  
  def featured
    @title = 'Featured Participation'
    @events = Event.featured.paginate :page => params[:page]
    render  :template => 'events/index.html.erb'
  end
  
  def autocomplete_list
    @events = Event.find(:all, :conditions => "title like '%#{params[:value]}%'")
    render :layout => false
  end
  
  def filter_by_tag
    @events = Event.tagged_with(params[:tag_name])
    render :template => 'events/index.html.erb'
  end
  # GET /events/1
  # GET /events/1.xml
  def show
    if cookies[:invite_event] and cookies[:invite_event].to_i.eql?(params[:id])
      flash[:notice] = "You have been invited to this event. Click on participate to join the event."
      cookies.delete(:invite_event)
      cookies.delete(:invite_code)
    end
    @event = Event.find(params[:id], :include => {:comments => []})
    @editorship = Editorship.new :editable => @event
    @new_comment = @event.comments.new(:name => current_user.name, :email => current_user.email, :user_id => current_user.id) if logged_in?
    @title = @event.title
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
    @title = 'New Event'
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    if current_user.is_admin? or current_user.editor?(@event)    
      @title = 'Editing Event'
    else
      flash[:notice] = 'You cannot edit this event.'
      redirect_to @event
    end
  end

  # POST /events
  # POST /events.xml
  def create
    process_params_for_tags 'event', 'cause'
    process_params_for_tags 'event', 'skill'
    @event = Event.new(params[:event])

    @event.user = current_user
    respond_to do |format|
      if @event.save
        flash[:notice] = 'Event was successfully created.'
        format.html { redirect_to(@event) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])
    if current_user.is_admin? or current_user.editor?(@event)    
    process_params_for_tags 'event', 'cause' 
    process_params_for_tags 'event', 'skill' 


    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to(@event) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
    else
      flash[:error] = 'You are not an editor for this event.'
      redirect_to @event
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    if current_user.is_admin? or current_user.editor?(@event)    
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
    else
      flash[:error] = 'You are not an editor for this event.'
      redirect_to events_url
    end
  end
  
  def feature
    @event = Event.find(params[:id])
    @event.feature!
    flash[:notice] = 'Event sucessfully featured.'
    respond_to do |format|
      format.html {redirect_to(@event)}
      format.xml  {head :ok}
    end
  end

  def complete
    @event = Event.find(params[:id])
    @event.complete!
    flash[:notice] = 'Event sucessfully completed.'
    respond_to do |format|
      format.html {redirect_to(@event)}
      format.xml  {head :ok}
    end
  end
  
  def match
    @event = Event.new(params[:event])
    if @event.valid?
      @events = Event.find_matching_events_to(Event.new(params[:event]))
    else
      render :action => :new
    end
  end
end
