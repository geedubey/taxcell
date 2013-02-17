class TDsalsController < ApplicationController
  before_filter :get_tpar_form
  
  # GET /t_dsals
  # GET /t_dsals.xml
  def index
    # disabling the current default behaviour to display all the TDSals
    #@t_dsals = TDsal.find(:all)
    @t_dsals = @tax_paid_and_refund.t_dsals

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @t_dsals }
    end
  end

  
  # GET /t_dsals/new
  # GET /t_dsals/new.xml
  def new
    @t_dsal = TDsal.new
    @t_dsal.tax_paid_and_refund_id = @tax_paid_and_refund.id
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @t_dsal }
    end
  end

  # GET /t_dsals/1/edit
  def edit
    #@t_dsal = TDsal.find(params[:id])
    @t_dsal = get_tdsal_form_paramid(params[:id])
  end

  

  # PUT /t_dsals/1
  # PUT /t_dsals/1.xml
  def update
    #@t_dsal = TDsal.find(params[:id])
    @t_dsal = get_tdsal_form_paramid(params[:id])

    respond_to do |format|
      if @t_dsal.update_attributes(params[:t_dsal])
        flash[:notice] = 'TDsal was successfully updated.'
        format.html {redirect_to(t_dsals_url)}
        #format.html { redirect_to(@t_dsal) }
        #format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @t_dsal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /t_dsals/1
  # DELETE /t_dsals/1.xml
  def destroy
    #@t_dsal = TDsal.find(params[:id])
    @t_dsal = get_tdsal_form_paramid(params[:id])
    @t_dsal.destroy

    respond_to do |format|
      format.html { redirect_to(t_dsals_url) }
      format.xml  { head :ok }
    end
  end
  
  # POST /t_dsals
  # POST /t_dsals.xml
  def create
    @t_dsal = TDsal.new(params[:t_dsal])
    @t_dsal.tax_paid_and_refund_id = @tax_paid_and_refund.id
    
    respond_to do |format|
      if @t_dsal.save
        flash[:notice] = 'TDsal was successfully created.'
        format.html {redirect_to(t_dsals_url)}
        #format.html { redirect_to(@t_dsal) }
        #format.xml  { render :xml => @t_dsal, :status => :created, :location => @t_dsal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @t_dsal.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private 
  # GET /t_dsals/1
  # GET /t_dsals/1.xml
  def show
    #@t_dsal = TDsal.find(params[:id])
    @t_dsal = @tax_paid_and_refund.t_dsals[0]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @t_dsal }
    end
  end
  
  def get_tdsal_form_paramid(paramid)
    @form = nil
    if(!paramid.nil?)
      @id = paramid.to_i
      if(@id > 0)
        @t_dsals = @tax_paid_and_refund.t_dsals
        for @f in @t_dsals
          if(@f.id == @id)
            @form = @f
          end
        end
      end
    end
    return @form
  end

end
