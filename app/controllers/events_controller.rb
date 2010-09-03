class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  
  before_filter :admin_required, :only => [:feature]
  def index
    @title = 'Events'
    params[:near] = params[:near].blank? ? 'unknown island' : params[:near]
    #@events = !params[:search].blank? ? Event.tagged_with(params[:search].split(','), :any => true).find(:all, :origin=> params[:near], :within => 25) : Event.find(:all, :origin => params[:near], :within => 25)
    @events = params[:search].blank? ? Event.all : Event.all(:origin=> params[:near], :within => 25, :conditions => "title like '%#{params[:search]}%'")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  def home
    @events = logged_in? ? current_user.suggested_events : Event.featured.find(:all, :limit => 5, :order => 'events.from')
    @badges = Badge.all(:limit => 9)
    @users = User.all(:limit => 10, :order => 'created_at desc')
  end
  
  def featured
    @title = 'Featured Events'
    @events = Event.featured
    render  :template => 'events/index.html.erb'
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
    @event = Event.find(params[:id])
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
    @title = 'Editing Event'
  end

  # POST /events
  # POST /events.xml
  def create
    process_params_for_tags 'event', 'cause'
    process_params_for_tags 'event', 'skill'
    @event = Event.new(params[:event])

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
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
  
  def feature
    @event = Event.find(params[:id])
    @event.feature
    flash[:notice] = 'Event sucessfully featured.'
    respond_to do |format|
      format.html {redirect_to(@event)}
      format.xml  {head :ok}
    end
  end
end
