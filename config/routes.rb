ActionController::Routing::Routes.draw do |map|
  map.resources :prizes

  map.resources :contests

  map.resources :badges

  map.root :controller => :events, :action => :home
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'  
  map.login2 '/login2', :controller => 'sessions', :action => 'new2'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.profile 'profile', :controller => :users, :action => :profile
  map.edit_profile 'profile/edit', :controller => :users, :action => :edit
  map.contesting_organizations '/contesting-organizations', :controller => 'organizations', :action => 'autocomplete_list'
  map.help_organization '/help/:id', :controller => :organization_users, :action => :help
  map.enter_contest '/enter/contest/:id', :controller => :contest_users, :action => :create
  map.participate_event '/participate/:id', :controller => :event_users, :action => :participate
  map.feature_event '/feature/event/:id', :controller => :events, :action => :feature  
  map.complete_event '/complete/event/:id', :controller => :events, :action => :complete
  map.event_feedback '/event/:id/feedback', :controller => :event_users, :action => :new      
  map.join_by_invitation '/join/:invite_code', :controller => :contacts, :action => :join_by_invitation
  map.participate_event_by_invitation '/join/event/:invite_code', :controller => :contacts, :action => :participate_event_by_invitation
  map.signup_step_one '/signup-1/', :controller => :users, :action => :set_address_and_preferences
  map.update_address  '/update-address/', :controller => :users, :action => :update_address_and_preferences
  map.signup_step_two '/signup-2/', :controller => :users, :action => :signup_step_two
  map.leader_board  '/leaders/', :controller => :users, :action => :leaders
  map.invite_to_event '/events/:id/invite', :controller => :contacts, :action => :invite_to_event
  map.share_event '/events/:id/share', :controller => :contacts, :action => :share_event  
  map.suggested_organizations '/suggested/organizations', :controller => :organizations, :action => :suggested
  map.featured_events 'featured/events', :controller => :events, :action => :featured
  map.suggested_events 'suggested/events', :controller => :events, :action => :suggested
  map.event_comments  'event/:id/comments/', :controller => :events, :action => :event_comments
  map.event_photos  'event/:id/photos/', :controller => :events, :action => :event_photos
  map.event_activities  'event/:id/activities/', :controller => :events, :action => :event_activities 
  map.editors 'editors', :controller => :users, :action => :editors
  map.delete_editor '/editorship/:editable_id/delete/:user_id', :controller => :editorships, :action => :delete
  map.delete_event 'events/:id/delete', :controller => :events, :action => :destroy
  map.signup_for_action 'signup/action/', :controller => :facebook_sessions, :action => :signup
#  map.new_pledge  '/pledges/new/', :controller  =>  :pledges, :action =>  :new
  map.resource :session
  map.resource  :event_user
  map.resources  :pledges
  map.resources   :pages
  map.resources   :discussions
  map.resources   :editorships
  map.resources :events
  map.resources :organizations do |organizations|
    organizations.resources :events
  end

  map.resources :users


  
  map.resources :sent, :messages
  
  map.inbox 'inbox',  :controller => 'received', :action => 'index'

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
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.

  map.connect 'events/filter/:tag_type/:tag_name', :controller => :events, :action => :filter_by_tag
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect ':name', :controller => :pages, :action => :show_by_name  
end
