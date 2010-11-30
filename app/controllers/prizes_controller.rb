class PrizesController < ApplicationController
  # GET /prizes
  # GET /prizes.xml
  def index
    @prizes = Prize.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @prizes }
    end
  end

  def autocomplete_list
    @prizes = Prize.find(:all, :conditions => "title like '%#{params[:value]}%'")
    render :layout => false
  end
  
  # GET /prizes/1
  # GET /prizes/1.xml
  def show
    @prize = Prize.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @prize }
    end
  end

  # GET /prizes/new
  # GET /prizes/new.xml
  def new
    @prize = Prize.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @prize }
    end
  end

  # GET /prizes/1/edit
  def edit
    @prize = Prize.find(params[:id])
  end

  # POST /prizes
  # POST /prizes.xml
  def create
    @prize = Prize.new(params[:prize])

    respond_to do |format|
      if @prize.save
        flash[:notice] = 'Prize was successfully created.'
        format.html { redirect_to(@prize) }
        format.xml  { render :xml => @prize, :status => :created, :location => @prize }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prize.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /prizes/1
  # PUT /prizes/1.xml
  def update
    @prize = Prize.find(params[:id])

    respond_to do |format|
      if @prize.update_attributes(params[:prize])
        flash[:notice] = 'Prize was successfully updated.'
        format.html { redirect_to(@prize) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prize.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /prizes/1
  # DELETE /prizes/1.xml
  def destroy
    @prize = Prize.find(params[:id])
    @prize.destroy

    respond_to do |format|
      format.html { redirect_to(prizes_url) }
      format.xml  { head :ok }
    end
  end
end
