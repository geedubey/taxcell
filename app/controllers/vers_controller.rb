class VersController < ApplicationController
  before_filter :get_form
  # GET /vers
  # GET /vers.xml
  def index
    @vers = [@form.ver]
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vers }
    end
  end

  
  # GET /vers/new
  # GET /vers/new.xml
  def new
    @ver = Ver.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ver }
    end
  end

  # GET /vers/1/edit
  def edit
    #@ver = Ver.find(params[:id])
    @ver = @form.ver
  end

  # PUT /vers/1
  # PUT /vers/1.xml
  def update
    #@ver = Ver.find(params[:id])
    @ver = @form.ver

    respond_to do |format|
      if @ver.update_attributes(params[:ver])
        flash[:notice] = 'Ver was successfully updated.'
        format.html { redirect_to(forms_url)}
        #format.html { redirect_to(@ver) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ver.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private 

  # DELETE /vers/1
  # DELETE /vers/1.xml
  def destroy
    @ver = Ver.find(params[:id])
    @ver.destroy

    respond_to do |format|
      format.html { redirect_to(vers_url) }
      format.xml  { head :ok }
    end
  end
  
  
  # POST /vers
  # POST /vers.xml
  def create
    @ver = Ver.new(params[:ver])

    respond_to do |format|
      if @ver.save
        flash[:notice] = 'Ver was successfully created.'
        format.html { redirect_to(@ver) }
        format.xml  { render :xml => @ver, :status => :created, :location => @ver }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ver.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /vers/1
  # GET /vers/1.xml
  def show
    #@ver = Ver.find(params[:id])
    @ver = @form.ver

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ver }
    end
  end

end
