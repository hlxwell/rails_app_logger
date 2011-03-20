class LogsController < ApplicationController
  before_filter :find_model, :except => [:index]

  # GET /logs
  # GET /logs.xml
  def index
    @logs = AppLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @logs }
    end
  end

  # GET /logs/1
  # GET /logs/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @log }
    end
  end

  # GET /logs/new
  # GET /logs/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @log }
    end
  end

  # GET /logs/1/edit
  def edit
  end

  # POST /logs
  # POST /logs.xml
  def create
    respond_to do |format|
      if @log.save
        format.html { redirect_to(@log, :notice => 'Log was successfully created.') }
        format.xml  { render :xml => @log, :status => :created, :location => @log }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /logs/1
  # PUT /logs/1.xml
  def update
    respond_to do |format|
      if @log.update_attributes(params[:log])
        format.html { redirect_to(@log, :notice => 'Log was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /logs/1
  # DELETE /logs/1.xml
  def destroy
    @log.destroy

    respond_to do |format|
      format.html { redirect_to(logs_url) }
      format.xml  { head :ok }
    end
  end

  private

  def find_model
    @log =  case
            when params[:id].present?
              AppLog.find(params[:id])
            when params[:app_log].present?
              @log = AppLog.new(params[:app_log])
            else
              @log = AppLog.new
            end
  end

end
