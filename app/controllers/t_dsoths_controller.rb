class TDsothsController < ApplicationController
  before_filter :get_tpar_form
  
  # GET /t_dsoths
  # GET /t_dsoths.xml
  def index
    #@t_dsoths = TDsoth.find(:all)
    @t_dsoths = @tax_paid_and_refund.t_dsoths

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @t_dsoths }
    end
  end

  
  # GET /t_dsoths/new
  # GET /t_dsoths/new.xml
  def new
    @t_dsoth = TDsoth.new
    @t_dsoth.tax_paid_and_refund_id = @tax_paid_and_refund.id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @t_dsoth }
    end
  end

  # GET /t_dsoths/1/edit
  def edit
    #@t_dsoth = TDsoth.find(params[:id])
    @t_dsoth = get_tdsoth_form_paramid(params[:id])
  end

  # PUT /t_dsoths/1
  # PUT /t_dsoths/1.xml
  def update
    #@t_dsoth = TDsoth.find(params[:id])
    @t_dsoth = get_tdsoth_form_paramid(params[:id])

    respond_to do |format|
      if @t_dsoth.update_attributes(params[:t_dsoth])
        flash[:notice] = 'TDsoth was successfully updated.'
        format.html { redirect_to(t_dsoths_url) }
        #format.html { redirect_to(@t_dsoth) }
        #format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @t_dsoth.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /t_dsoths/1
  # DELETE /t_dsoths/1.xml
  def destroy
    #@t_dsoth = TDsoth.find(params[:id])
    @t_dsoth = get_tdsoth_form_paramid(params[:id])
    @t_dsoth.destroy

    respond_to do |format|
      format.html { redirect_to(t_dsoths_url) }
      format.xml  { head :ok }
    end
  end

  # POST /t_dsoths
  # POST /t_dsoths.xml
  def create
    @t_dsoth = TDsoth.new(params[:t_dsoth])
    @t_dsoth.tax_paid_and_refund_id = @tax_paid_and_refund.id

    respond_to do |format|
      if @t_dsoth.save
        flash[:notice] = 'TDsoth was successfully created.'
        format.html { redirect_to(t_dsoths_url) }
        #format.html { redirect_to(@t_dsoth) }
        #format.xml  { render :xml => @t_dsoth, :status => :created, :location => @t_dsoth }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @t_dsoth.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private
  # GET /t_dsoths/1
  # GET /t_dsoths/1.xml
  def show
    #@t_dsoth = TDsoth.find(params[:id])
    @t_dsoth = @tax_paid_and_refund.t_dsoths[0]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @t_dsoth }
    end
  end
  
  def get_tdsoth_form_paramid(paramid)
    @form = nil
    if(!paramid.nil?)
      @id = paramid.to_i
      if(@id > 0)
        @t_dsoths = @tax_paid_and_refund.t_dsoths
        for @f in @t_dsoths
          if(@f.id == @id)
            @form = @f
          end
        end
      end
    end
    return @form
  end

end
