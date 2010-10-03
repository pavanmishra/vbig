class OrganizationsController < ApplicationController
  # GET /organizations
  # GET /organizations.xml
  before_filter :login_required, :only => [:suggested]
  
  def index
    @organizations = params[:search].blank? ? Organization.paginate(:order => 'created_at DESC', :page => params[:page]) : Organization.paginate(:conditions => "name like '%#{params[:search]}%'", :page => params[:page])
    @title = "Recent NGO's"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @organizations }
    end
  end

  def suggested
    @organizations = current_user.suggested_organizations(params[:page])
    @title = 'Organizations Suggested to You'
    render :template => 'organizations/index'
  end
  
  
  # GET /organizations/1
  # GET /organizations/1.xml
  def show
    @organization = Organization.find(params[:id])
    # following query uses the mysql current function
    @recent_events = @organization.events.find(:all, :conditions => "date(from_date) < current_date() ")
    @upcoming_events = @organization.events.find(:all, :conditions => "date(from_date) > current_date() ")
    @title = @organization.name
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @organization }
    end
  end

  # GET /organizations/new
  # GET /organizations/new.xml
  def new
    @organization = Organization.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @organization }
    end
  end

  # GET /organizations/1/edit
  def edit
    @organization = Organization.find(params[:id])
  end

  # POST /organizations
  # POST /organizations.xml
  def create
    process_params_for_tags 'organization', 'cause'
    process_params_for_tags 'organization', 'skill'
    
    @organization = Organization.new(params[:organization])
    @organization.user = current_user
    respond_to do |format|
      if @organization.save
        flash[:notice] = 'Organization was successfully created.'
        format.html { redirect_to(@organization) }
        format.xml  { render :xml => @organization, :status => :created, :location => @organization }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /organizations/1
  # PUT /organizations/1.xml
  def update
    @organization = Organization.find(params[:id])
    process_params_for_tags 'organization', 'cause'
    process_params_for_tags 'organization', 'skill'
    
    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        flash[:notice] = 'Organization was successfully updated.'
        format.html { redirect_to(@organization) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.xml
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to(organizations_url) }
      format.xml  { head :ok }
    end
  end
end
