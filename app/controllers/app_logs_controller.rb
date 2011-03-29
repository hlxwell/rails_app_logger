class AppLogsController < ApplicationController
  before_filter :find_model, :except => [:index]

  # GET /app_logs
  # GET /app_logs.xml
  def index
    @app_logs = AppLog.order_by(:created_at.desc).page(params[:page]).per(20)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @app_logs }
    end
  end

  # GET /app_logs/1
  # GET /app_logs/1.xml
  def show
    @repeating_requests = @app_log.repeating_requests.page(params[:page]).per(20)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @app_log }
    end
  end

  # GET /app_logs/new
  # GET /app_logs/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @app_log }
    end
  end

  # GET /app_logs/1/edit
  def edit
  end

  # POST /app_logs
  # POST /app_logs.xml
  def create
    respond_to do |format|
      if @app_log.save
        format.html { redirect_to(@app_log, :notice => 'App log was successfully created.') }
        format.xml  { render :xml => @app_log, :status => :created, :location => @app_log }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @app_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /app_logs/1
  # PUT /app_logs/1.xml
  def update
    respond_to do |format|
      if @app_log.update_attributes(params[:app_log])
        format.html { redirect_to(@app_log, :notice => 'App log was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @app_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /app_logs/1
  # DELETE /app_logs/1.xml
  def destroy
    @app_log.destroy

    respond_to do |format|
      format.html { redirect_to(app_logs_url) }
      format.xml  { head :ok }
    end
  end

  private

  def find_model
    @app_log =  case
                when params[:id].present?
                  AppLog.find(params[:id])
                when params[:app_log].present?
                  @log = AppLog.new(params[:app_log])
                else
                  @log = AppLog.new
                end
  end
end
