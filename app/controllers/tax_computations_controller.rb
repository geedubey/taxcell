class TaxComputationsController < ApplicationController
  before_filter :get_form
  
  # GET /tax_computations
  # GET /tax_computations.xml
  def index
    @tax_computations = [@form.tax_computation]
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tax_computations }
    end
  end

  
  # GET /tax_computations/new
  # GET /tax_computations/new.xml
  def new
    @tax_computation = TaxComputation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tax_computation }
    end
  end

  # GET /tax_computations/1/edit
  def edit
    flash[:notice] = 'In this section we will compute your income tax.'
    #@tax_computation = TaxComputation.find(params[:id])
    @tax_computation = @form.tax_computation
  end

  # PUT /tax_computations/1
  # PUT /tax_computations/1.xml
  def update
    #@tax_computation = TaxComputation.find(params[:id])
    @tax_computation = @form.tax_computation

    respond_to do |format|
      if @tax_computation.update_attributes(params[:tax_computation])
        #flash[:notice] = 'TaxComputation was successfully updated.'
        #format.html { redirect_to(@tax_computation) }
        @tax_paid_and_refund = @form.tax_paid_and_refund
        format.html {redirect_to :controller=>'tax_paid_and_refunds', :action=>'edit', :id => @tax_paid_and_refund.id}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tax_computation.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private 

  # DELETE /tax_computations/1
  # DELETE /tax_computations/1.xml
  def destroy
    @tax_computation = TaxComputation.find(params[:id])
    @tax_computation.destroy

    respond_to do |format|
      format.html { redirect_to(tax_computations_url) }
      format.xml  { head :ok }
    end
  end
  
  
  # POST /tax_computations
  # POST /tax_computations.xml
  def create
    @tax_computation = TaxComputation.new(params[:tax_computation])

    respond_to do |format|
      if @tax_computation.save
        #flash[:notice] = 'TaxComputation was successfully created.'
        format.html { redirect_to(@tax_computation) }
        format.xml  { render :xml => @tax_computation, :status => :created, :location => @tax_computation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tax_computation.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /tax_computations/1
  # GET /tax_computations/1.xml
  def show
    #@tax_computation = TaxComputation.find(params[:id])
    @tax_computation = @form.tax_computation

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tax_computation }
    end
  end

end


