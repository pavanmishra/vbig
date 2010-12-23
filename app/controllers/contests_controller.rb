class ContestsController < ApplicationController
  # GET /contests
  # GET /contests.xml
  def index
    @contests = Contest.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contests }
    end
  end

  # GET /contests/1
  # GET /contests/1.xml
  def show
    @contest = Contest.find(params[:id])
    @contest_organization = ContestOrganization.new :contest => @contest
    @contest_sponsor  = ContestSponsor.new :contest => @contest
    @contest_prize = ContestPrize.new :contest => @contest
    @contest_event = ContestEvent.new :contest => @contest
    @top_users_score_list = Activity.find_by_sql("select sum(points) as total_points, user_id from activities where contest_id=#{@contest.id} group by user_id order by sum(points) desc limit 5")
    @top_organizations_score_list = Activity.find_by_sql("select sum(points) as total_points, subject_id from activities where contest_id=#{@contest.id} and subject_type='Organization' group by subject_id order by sum(points) desc limit 5")
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contest }
    end
  end

  def add_sponsor
    contest_sponsor = ContestSponsor.create params[:contest_sponsor]
    redirect_to contest_sponsor.contest
  end

  def add_prize
    contest_prize = ContestPrize.create params[:contest_prize]
    redirect_to contest_prize.contest
  end

  def add_event
    contest_event = ContestEvent.create params[:contest_event]
    redirect_to contest_event.contest
  end

  # GET /contests/new
  # GET /contests/new.xml
  def new
    @contest = Contest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contest }
    end
  end

  # GET /contests/1/edit
  def edit
    @contest = Contest.find(params[:id])
  end

  # POST /contests
  # POST /contests.xml
  def create
    @contest = Contest.new(params[:contest])
    @contest.sponsors << Sponsor.find(params[:for_sponsor]) unless params[:for_sponsor].empty?
    respond_to do |format|
      if @contest.save
        flash[:notice] = 'Contest was successfully created.'
        format.html { redirect_to(@contest) }
        format.xml  { render :xml => @contest, :status => :created, :location => @contest }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contests/1
  # PUT /contests/1.xml
  def update
    @contest = Contest.find(params[:id])

    respond_to do |format|
      if @contest.update_attributes(params[:contest])
        flash[:notice] = 'Contest was successfully updated.'
        format.html { redirect_to(@contest) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contests/1
  # DELETE /contests/1.xml
  def destroy
    @contest = Contest.find(params[:id])
    @contest.destroy

    respond_to do |format|
      format.html { redirect_to(contests_url) }
      format.xml  { head :ok }
    end
  end
  
  def add_organization
    contest_organization = ContestOrganization.create params[:contest_organization]
    redirect_to contest_organization.contest
  end
  
  def organizations
    @contest = Contest.find(params[:id])
    @organizations = @contest.organizations
  end
  
  def participants
    @contest = Contest.find(params[:id])
    @users = @contest.users
  end
  
  def invite_to_contest
    @social_invites = Invitation.create_social_invites_for_invitable_components(current_user, Contest.find(params[:id]), params[:for], params[:for_id])
    render  :layout => false
  end
end
