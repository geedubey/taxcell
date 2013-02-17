class TaxPaidAndRefundsController < ApplicationController
  before_filter :get_form
  # GET /tax_paid_and_refunds
  # GET /tax_paid_and_refunds.xml
  def index
    @tax_paid_and_refunds = [@form.tax_paid_and_refund]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tax_paid_and_refunds }
    end
  end

  
  # GET /tax_paid_and_refunds/new
  # GET /tax_paid_and_refunds/new.xml
  def new
    @tax_paid_and_refund = TaxPaidAndRefund.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tax_paid_and_refund }
    end
  end

  # GET /tax_paid_and_refunds/1/edit
  def edit
    flash[:notice] = 'Fill Your Tax Paid and Refund.'
    #@tax_paid_and_refund = TaxPaidAndRefund.find(params[:id])
    @tax_paid_and_refund = @form.tax_paid_and_refund
  end

  # PUT /tax_paid_and_refunds/1
  # PUT /tax_paid_and_refunds/1.xml
  def update
    #@tax_paid_and_refund = TaxPaidAndRefund.find(params[:id])
    @tax_paid_and_refund = @form.tax_paid_and_refund

    respond_to do |format|
      if @tax_paid_and_refund.update_attributes(params[:tax_paid_and_refund])
        #flash[:notice] = 'TaxPaidAndRefund was successfully updated.'
        # set_tparid_in_session(@tax_paid_and_refund.id)
        # currently set immediately after selecting the form itself. 
        #format.html { redirect_to(@tax_paid_and_refund) }
=begin
        #disabling the current flow to direct towards the AIR table 
        @air = @form.air
        format.html {redirect_to :controller=>'airs', :action=>'edit', :id => @air.id}
=end
        format.html {redirect_to :controller=>'t_dsals', :action=>'index'}        
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tax_paid_and_refund.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private

  # DELETE /tax_paid_and_refunds/1
  # DELETE /tax_paid_and_refunds/1.xml
  def destroy
    @tax_paid_and_refund = TaxPaidAndRefund.find(params[:id])
    @tax_paid_and_refund.destroy

    respond_to do |format|
      format.html { redirect_to(tax_paid_and_refunds_url) }
      format.xml  { head :ok }
    end
  end
  
  
  
  # POST /tax_paid_and_refunds
  # POST /tax_paid_and_refunds.xml
  def create
    @tax_paid_and_refund = TaxPaidAndRefund.new(params[:tax_paid_and_refund])

    respond_to do |format|
      if @tax_paid_and_refund.save
        #flash[:notice] = 'TaxPaidAndRefund was successfully created.'
        format.html { redirect_to(@tax_paid_and_refund) }
        format.xml  { render :xml => @tax_paid_and_refund, :status => :created, :location => @tax_paid_and_refund }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tax_paid_and_refund.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /tax_paid_and_refunds/1
  # GET /tax_paid_and_refunds/1.xml
  def show
    #@tax_paid_and_refund = TaxPaidAndRefund.find(params[:id])
    @tax_paid_and_refund = @form.tax_paid_and_refund

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tax_paid_and_refund }
    end
  end

end

