# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  require 'rubygems'
  require 'aasm'
  #include ExceptionNotifiable
  #custom error
  require "#{RAILS_ROOT}/vendor/plugins/custom-err-msg/lib/custom_error_message.rb"
  
  layout 'general'
  
  
  # filter below adds the requirement to be logged in before accessing the sections of website
  # exceptions to this access ( welcome page and login(session) page) haev been added into the respective
  # controllers. TODO - From code maintenance point of view it will be good to move it here. Currently I 
  # am not able to fugure out the code for the same. 
  # Controllers with exceptions ::: welcome, session
  # contact : vipin/dubey
  #before_filter :login_required , :except => [:User]
    
  helper :all # include all helpers, all the time


  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => '0fb0e02e8d173865d70e2d9b52dd5139'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  
  ############################### CODE FOR ITR 2009 #########################  
  
  private 
  # get_form - method is callled before any of the form dependent controller 
  # gets called on. It gets form based on form id saved in session
  # Ignore warning here. method is called in derived classes.
  def get_form
    @formid = session[:formid]
    if @formid
      @form = Form.find(@formid) # by default search by ID
    else
      #TODO - do the error handling. how come the formid is NIL
      #should we take it to login by calling 'login_required'
      #that will make sense if we are sure that 
    end
  end  
  
  def get_tpar_form
    @tparid = session[:tparid]
    if @tparid
      @tax_paid_and_refund = TaxPaidAndRefund.find(@tparid) # by default search by ID
    else
      #TODO - do the error handling. how come the taprid is NIL      
    end
  end

 
  #add a SNGLE copy of all three dependent forms of Tax Paid and Refund
  # TODO - do error handling
  def add_taxpaid_and_refund_forms(id)
    @t_dsal = TDsal.new
    @t_dsoth = TDsoth.new
    @tax_p = TaxP.new
    
    @t_dsal.tax_paid_and_refund_id  = @t_dsoth.tax_paid_and_refund_id  = @tax_p.tax_paid_and_refund_id = id
    @flag = @t_dsal.save(false) && @t_dsoth.save(false) && @tax_p.save(false)
  end  
  
  # sets/updates the id of the form (passed in as argument) in the function
  # it has been called from various places considering that the form being 
  # worked upon becomes the active form. i.e. the one being edited, created,
  # updated. 
  def set_session_forms_id(form)
    session[:formid] = form.id
    session[:tparid] = form.tax_paid_and_refund.id
  end
  
  #clears off the session ids set in the above function.
  def clear_session_forms_id
    session[:formid] = nil
    session[:tparid] = nil
  end
  
  #sets the @user based on current_user varibale
  def get_user
    if(current_user)    
      @user = current_user
    else
      @user = NIL#TODO - Error handling. current_user should not be NIL here. stop somewhere.      
    end
  end
  
  def get_form_paramid(paramid)
    @form = nil
    if(!paramid.nil?)
      @id = paramid.to_i
      if(@id > 0)
        @forms = @user.forms
        for @f in @forms
          if(@f.id == @id)
            @form = @f
          end
        end
      end
    end
    return @form
  end
  
end
