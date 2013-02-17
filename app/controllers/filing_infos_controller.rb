class FilingInfosController < ApplicationController
  before_filter :get_form
  
  # GET /filing_infos
  # GET /filing_infos.xml
  def index
    #@filing_infos = FilingInfo.find(:all) # show only current 
    @filing_infos = [@form.filing_info]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @filing_infos }
    end
  end

  
  # GET /filing_infos/new
  # GET /filing_infos/new.xml
  def new
    @filing_info = FilingInfo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @filing_info }
    end
  end

  # GET /filing_infos/1/edit
  def edit
    flash[:notice] = 'The purpose of this Form is to get status of your filing'
    #@filing_info = FilingInfo.find(params[:id])
    @filing_info = @form.filing_info
  end

  # PUT /filing_infos/1
  # PUT /filing_infos/1.xml
  def update
    #@filing_info = FilingInfo.find(params[:id])
    @filing_info = @form.filing_info

    respond_to do |format|
      if @filing_info.update_attributes(params[:filing_info])
        #flash[:notice] = 'FilingInfo was successfully updated.'
        #format.html { redirect_to(@filing_info) }
        @income_and_deductions = @form.income_and_deduction
        format.html {redirect_to :controller=>'income_and_deductions', :action=>'edit', :id => @income_and_deductions.id}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @filing_info.errors, :status => :unprocessable_entity }
      end
    end
  end

  private 
  # DELETE /filing_infos/1
  # DELETE /filing_infos/1.xml
  def destroy
    @filing_info = FilingInfo.find(params[:id])
    @filing_info.destroy

    respond_to do |format|
      format.html { redirect_to(filing_infos_url) }
      format.xml  { head :ok }
    end
  end
  
  
    # POST /filing_infos
  # POST /filing_infos.xml
  def create
    @filing_info = FilingInfo.new(params[:filing_info])

    respond_to do |format|
      if @filing_info.save
        #flash[:notice] = 'FilingInfo was successfully created.'
        format.html { redirect_to(@filing_info) }
        format.xml  { render :xml => @filing_info, :status => :created, :location => @filing_info }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @filing_info.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /filing_infos/1
  # GET /filing_infos/1.xml
  def show
    #@filing_info = FilingInfo.find(params[:id])
    @filing_info = @form.filing_info

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @filing_info}
    end
  end


end
