class TaxPsController < ApplicationController
  before_filter :get_form 
  before_filter :get_tpar_form
  
  # GET /tax_ps
  # GET /tax_ps.xml
  def index
    #@tax_ps = TaxP.find(:all)
    @tax_ps = @tax_paid_and_refund.tax_ps

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tax_ps }
    end
  end

  

  # GET /tax_ps/new
  # GET /tax_ps/new.xml
  def new
    @tax_p = TaxP.new
    @tax_p.tax_paid_and_refund_id = @tax_paid_and_refund.id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tax_p }
    end
  end

  # GET /tax_ps/1/edit
  def edit
    #@tax_p = TaxP.find(params[:id])
    @tax_p = get_taxp_form_paramid(params[:id])
  end

  # PUT /tax_ps/1
  # PUT /tax_ps/1.xml
  def update
    #@tax_p = TaxP.find(params[:id])
    @tax_p = get_taxp_form_paramid(params[:id])

    respond_to do |format|
      if @tax_p.update_attributes(params[:tax_p])
        flash[:notice] = 'TaxP was successfully updated.'
        format.html { redirect_to(tax_ps_url) }
        #format.html { redirect_to(@tax_p) }
        #format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tax_p.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tax_ps/1
  # DELETE /tax_ps/1.xml
  def destroy
    #@tax_p = TaxP.find(params[:id])
    @tax_p = get_taxp_form_paramid(params[:id])
    @tax_p.destroy

    respond_to do |format|
      format.html { redirect_to(tax_ps_url) }
      format.xml  { head :ok }
    end
  end
  

  # POST /tax_ps
  # POST /tax_ps.xml
  def create
    @tax_p = TaxP.new(params[:tax_p])
    @tax_p.tax_paid_and_refund_id = @tax_paid_and_refund.id

    respond_to do |format|
      if @tax_p.save
        flash[:notice] = 'TaxP was successfully created.'
        format.html { redirect_to(tax_ps_url) }
        # format.html { redirect_to(@tax_p) }
        # format.xml  { render :xml => @tax_p, :status => :created, :location => @tax_p }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tax_p.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private 
  # GET /tax_ps/1
  # GET /tax_ps/1.xml
  def show
    #@tax_p = TaxP.find(params[:id])
    @tax_p = @tax_paid_and_refund.tax_ps[0]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tax_p }
    end
  end
  
  def get_taxp_form_paramid(paramid)
    @form = nil
    if(!paramid.nil?)
      @id = paramid.to_i
      if(@id > 0)
        @tax_ps = @tax_paid_and_refund.tax_ps
        for @f in @tax_ps
          if(@f.id == @id)
            @form = @f
          end
        end
      end
    end
    return @form
  end
  
end
