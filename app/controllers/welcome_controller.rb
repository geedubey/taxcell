class WelcomeController < ApplicationController
  #skip_before_filter :login_required # TODO - the commented code will debar complete controller
  # from the login_required authenticatio. By using the following code currently allowing only the 
  # index method of the controller. Obviously "welcome" page should not require any login. - vipin/dubey
  before_filter :login_required, :except=>[:index]
  
  def index
    clear_session_forms_id
  end

end
