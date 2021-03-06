Vollaa::Application.routes.draw do

  post '/home/saved_properties' => "home#saved_properties"
  match 'home/remove_save_prop', :to => 'home#remove_save_prop'
  match 'home/adv_search', :to => 'home#adv_search'

  resources :profiles

  get "property_map/index"

  devise_for :users, :controller => {:OmniauthCallback => "user/OmniauthCallback"}

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  match "property_map", :to => 'property_map#index', :as => :property_map
  match "/about", :to => "application#about"
  match "/policy", :to => "application#policy"
  match "/contact", :to => "application#contactus"
  match "/trends", :to => "application#trends"
  match "/tools", :to => "application#tools"
  match "/advertise", :to => "application#advertise"

  match 'vollaa_property_:id' => 'properties#vollaa_property_show', :as => 'vollaa_property_show'
  resources :properties do
    collection do

    end
  end

  resource :home do
    collection do
      get  'results'
      post 'send_details'
      get  'search'
      get  'contact'
      get  'about'
      get  'terms'
      get  'view_results'
      post 'revert_recent'
      get  'side_nav'
    end
  end

  root :to => 'home#search'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.erb.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
