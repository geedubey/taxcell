class IncomeAndDeductionsController < ApplicationController
  before_filter :get_form
  
  # GET /income_and_deductions
  # GET /income_and_deductions.xml
  def index
    #@income_and_deductions = IncomeAndDeduction.find(:all) #show only relevant information
    @income_and_deductions = @form.income_and_deduction 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @income_and_deductions }
    end
  end

  
  # GET /income_and_deductions/new
  # GET /income_and_deductions/new.xml
  def new
    @income_and_deduction = IncomeAndDeduction.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @income_and_deduction }
    end
  end

  # GET /income_and_deductions/1/edit
  def edit
    flash[:notice] = 'Now you need to Fill your income and Savings (Deductions)'
    #@income_and_deduction = IncomeAndDeduction.find(params[:id])
    @income_and_deduction = @form.income_and_deduction
  end

  # PUT /income_and_deductions/1
  # PUT /income_and_deductions/1.xml
  def update
    #@income_and_deduction = IncomeAndDeduction.find(params[:id])
    @income_and_deduction = @form.income_and_deduction

    respond_to do |format|
      if @income_and_deduction.update_attributes(params[:income_and_deduction])
        #flash[:notice] = 'IncomeAndDeduction was successfully updated.'
        #format.html { redirect_to(@income_and_deduction) }
        @tax_computation = @form.tax_computation
        format.html {redirect_to :controller=>'tax_computations', :action=>'edit', :id => @tax_computation.id}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @income_and_deduction.errors, :status => :unprocessable_entity }
      end
    end
  end

  private 
  # DELETE /income_and_deductions/1
  # DELETE /income_and_deductions/1.xml
  def destroy
    @income_and_deduction = IncomeAndDeduction.find(params[:id])
    @income_and_deduction.destroy

    respond_to do |format|
      format.html { redirect_to(income_and_deductions_url) }
      format.xml  { head :ok }
    end
  end
  
  
  # POST /income_and_deductions
  # POST /income_and_deductions.xml
  def create
    @income_and_deduction = IncomeAndDeduction.new(params[:income_and_deduction])

    respond_to do |format|
      if @income_and_deduction.save
        #flash[:notice] = 'IncomeAndDeduction was successfully created.'
        format.html { redirect_to(@income_and_deduction) }
        format.xml  { render :xml => @income_and_deduction, :status => :created, :location => @income_and_deduction }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @income_and_deduction.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /income_and_deductions/1
  # GET /income_and_deductions/1.xml
  def show
    #@income_and_deduction = IncomeAndDeduction.find(params[:id])
    @income_and_deduction = @form.income_and_deduction

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @income_and_deduction }
    end
  end

end
