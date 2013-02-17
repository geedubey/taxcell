class PersonalInfosController < ApplicationController
  before_filter :get_form
  # GET /personal_infos
  # GET /personal_infos.xml
  def index
    #@personal_infos = PersonalInfo.find(:all)
    #Scaffolding generates the code mostly considering that 
    #eveything will get pluralized and hence all the show/index
    # and othe html.erb(s) have the code written to traverse on
    #arrays. So making it an array too. So that we have an easy 
    #option to switch back when needed and don;t need to change the views
    # much. - vipin
    
    @personal_infos = [@form.personal_info] 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @personal_infos }
    end
  end

  
  # GET /personal_infos/new
  # GET /personal_infos/new.xml
  def new
    @personal_info = PersonalInfo.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @personal_info }
    end
  end

  # GET /personal_infos/1/edit
  def edit
    flash[:notice] = 'The purpose of this Form is to Enter your personal detials for tax purposes.These details will go in ITR-1 form.'
    #@personal_info = PersonalInfo.find(params[:id])
    @personal_info = @form.personal_info
  end

  # PUT /personal_infos/1
  # PUT /personal_infos/1.xml
  def update
    #@personal_info = PersonalInfo.find(params[:id])
    @personal_info = @form.personal_info

    respond_to do |format|
      if @personal_info.update_attributes(params[:personal_info])
        #flash[:notice] = 'PersonalInfo was successfully updated.'
        #format.html { redirect_to(@personal_info) }
        @filing_info = @form.filing_info
        format.html {redirect_to :controller=>'filing_infos', :action=>'edit', :id => @filing_info.id}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @personal_info.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private 
  # DELETE /personal_infos/1
  # DELETE /personal_infos/1.xml
  def destroy
    @personal_info = PersonalInfo.find(params[:id])
    @personal_info.destroy

    respond_to do |format|
      format.html { redirect_to(personal_infos_url) }
      format.xml  { head :ok }
    end
  end  
  
  
  # POST /personal_infos
  # POST /personal_infos.xml
  def create
    @personal_info = PersonalInfo.new(params[:personal_info])

    respond_to do |format|
      if @personal_info.save
        #flash[:notice] = 'PersonalInfo was successfully created.'
        format.html { redirect_to(@personal_info) }
        format.xml  { render :xml => @personal_info, :status => :created, :location => @personal_info }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @personal_info.errors, :status => :unprocessable_entity }
      end
    end
  end  
  
  # GET /personal_infos/1
  # GET /personal_infos/1.xml
  def show
    # never allow anyone to see the personal info based on URL editing
    #@personal_info = PersonalInfo.find(params[:id])
    @personal_info = @form.personal_info

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @personal_info }
    end
  end

  
end

