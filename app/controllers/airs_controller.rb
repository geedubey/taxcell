class AirsController < ApplicationController
  before_filter :get_form
  
  # GET /airs
  # GET /airs.xml
  def index
    @airs = [@form.air]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @airs }
    end
  end

  
  # GET /airs/new
  # GET /airs/new.xml
  def new
    @air = Air.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @air }
    end
  end

  # GET /airs/1/edit
  def edit
    #@air = Air.find(params[:id])
    @air = @form.air
  end

  # PUT /airs/1
  # PUT /airs/1.xml
  def update
    #@air = Air.find(params[:id])
    @air = @form.air

    respond_to do |format|
      if @air.update_attributes(params[:air])
        flash[:notice] = 'Air was successfully updated.'
        #format.html { redirect_to(@air) }
        @ver = @form.ver
        format.html {redirect_to :controller=>'vers', :action=>'edit', :id => @ver.id}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @air.errors, :status => :unprocessable_entity }
      end
    end
  end

  private
  # DELETE /airs/1
  # DELETE /airs/1.xml
  def destroy
    @air = Air.find(params[:id])
    @air.destroy

    respond_to do |format|
      format.html { redirect_to(airs_url) }
      format.xml  { head :ok }
    end
  end
  
  
  # POST /airs
  # POST /airs.xml
  def create
    @air = Air.new(params[:air])

    respond_to do |format|
      if @air.save
        flash[:notice] = 'Air was successfully created.'
        format.html { redirect_to(@air) }
        format.xml  { render :xml => @air, :status => :created, :location => @air }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @air.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /airs/1
  # GET /airs/1.xml
  def show
    #@air = Air.find(params[:id])
    @air = @form.air

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @air }
    end
  end

end
