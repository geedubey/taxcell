ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users, :member => { :suspend => :put, :unsuspend => :put, :purge => :delete }
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  # map.register '/register', :controller => 'users', :action => 'create'
  
  map.forgot_password '/forgot_password', :controller => 'users', :action => 'forgot_password'
  map.reset_password '/reset_password/:id', :controller => 'users', :action => 'reset_password' 

  map.resource :session
  
  map.resources :vers

  map.resources :airs

  map.resources :tax_ps

  map.resources :t_dsoths

  map.resources :t_dsals

  map.resources :tax_paid_and_refunds

  map.resources :tax_computations

  map.resources :income_and_deductions

  map.resources :filing_infos

  map.resources :personal_infos

  map.resources :forms
  
  map.resources :pdf_writer
  
  map.resources :xml_writer
  #named route for download - TODO 
  map.xmldownload 'xml_writer/:id/xmldownload', :controller => 'xml_writer', :action => 'xmldownload'
  map.pdfdownload 'pdf_writer/:id/pdfdownload', :controller => 'pdf_writer', :action => 'pdfdownload'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
 # map.connect ':controller/:action/:id'
 # map.connect ':controller/:action/:id.:format'
  # map.route '/:controller/:action' 
end
