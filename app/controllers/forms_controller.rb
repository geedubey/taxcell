class FormsController < ApplicationController
  #before conrtoller operations 
  before_filter :get_user  
  
  # GET /forms
  # GET /forms.xml  
  def index
    # WARNING : show a user only his forms.
    # @forms = Form.find(:all) # dangerous 
    @forms = @user.forms
    clear_session_forms_id
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forms }
    end
  end

  
  # GET /forms/new
  # GET /forms/new.xml
  # NOTE : new just creates a temporary form for the user. 
  # only when it has been saved ('create' clicked by user)
  # we should make associations 
  def new
    @form = Form.new
    @form.formName  = "personal" # sets the default name
    # Do not let the users specify the User ID. it can show them others forms.
    @form.user_id = @user.id # specify the user id in the form yourself.    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @form }
    end
  end

  # GET /forms/1/edit
  def edit
    #allow people to edit only their forms. 
    #@form = Form.find(params[:id])
    @form = get_form_paramid(params[:id])
    if(@form != nil)
      set_session_forms_id(@form)
    else    
      # if user trying to manipulate with URL manually then
      # warn him and take back to the forms.    
      flash[:alert] = "No form found with ID - #{params[:id]}"
      redirect_to(forms_url)
    end
    
  end
  
  # POST /forms
  # POST /forms.xml
  def create
    @form = Form.new(params[:form])
    # Do not let the users specify the User ID. it can show them others forms.
    @form.user_id = @user.id # specify the user id in the form yourself.    
    respond_to do |format|
      if @form.save
        # create dependent forms based on this form.
        create_sub_forms(@form)        
        set_session_forms_id(@form) #save the form id in session
        @pinfo = @form.personal_info
        format.html {redirect_to :controller=>'personal_infos', :action=>'edit', :id => @pinfo.id}
        format.xml  { head :ok }        
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @form.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /forms/1
  # PUT /forms/1.xml
  def update
    #@form = Form.find(params[:id])
    @form = get_form_paramid(params[:id])
    
    if(@form.user_id == @user.id)    
      respond_to do |format|
        if @form.update_attributes(params[:form])
          #flash[:notice] = 'Form was successfully updated.'
          #format.html { redirect_to(@form) }
          @pinfo = @form.personal_info
          format.html {redirect_to :controller=>'personal_infos', :action=>'edit', :id => @pinfo.id}
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @form.errors, :status => :unprocessable_entity }
        end
      end
    else  # Somebody trying to modify the user id of the form. DO NOT ALLOW.
      # TODO - handle the error better. why to tell him he is trying user id ??
      #flash[:notice] = 'Form can not be updated with user id.'
      format.html { redirect_to(@form) }
      format.xml  { head :ok }      
    end
  end

  # DELETE /forms/1
  # DELETE /forms/1.xml
  def destroy
    #@form = Form.find(params[:id])
    @form = get_form_paramid(params[:id])
    @form.destroy

    respond_to do |format|
      format.html { redirect_to(forms_url) }
      format.xml  { head :ok }
    end
  end

  # PRIVATE methods
  private
  
  #creates the sub forms for every form created. 
  def create_sub_forms(form)
    @flag = true
    @pinfo = PersonalInfo.new
    @air = Air.new
    @filing_info = FilingInfo.new
    @incomeanddeduction = IncomeAndDeduction.new
    @taxcomputation = TaxComputation.new
    @tax_paid_and_refund  = TaxPaidAndRefund.new
    @ver = Ver.new   
    
    # make the association of subforms with the main form info with the 
    # help of form ids. - vipin
    @air.form_id = @pinfo.form_id = @filing_info.form_id = form.id
    @incomeanddeduction.form_id = @taxcomputation.form_id = form.id
    @tax_paid_and_refund.form_id = @ver.form_id = form.id 
    
    @flag = @tax_paid_and_refund.save(false)
    if(@flag)
    # create single copy of TaxP/ TDSal/TDSoth forms 
    # disabling the creation of sub forms here. Currently the flow is to ask 
    # the user to create it on the demand basis. 
    # @flag = add_taxpaid_and_refund_forms(@tax_paid_and_refund.id)
      if(@flag)
        @flag = @air.save(false) && @pinfo.save(false) && @filing_info.save(false)
        @flag = @flag && @incomeanddeduction.save(false) && @taxcomputation.save(false)
        @flag = @flag && @ver.save(false)
        if(@flag)
          # Hopefully everythig went fine.
        else
          #TODO - not able to save the remaining forms. 
        end
      else      
        #TODO - Error Handling - not able to create tax paid and refund SUB FORMS
      end
    else
#    TODO - Error handling - can not save Tax Paid and Refund Form
    end    
    
    if(@flag == false)
      # TODO - do better error handling. can not create sub forms. 
    end
  end
  
  # GET /forms/1
  # GET /forms/1.xml
  def show
    @form = Form.find(params[:id])  

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @form }
    end
  end  

end
