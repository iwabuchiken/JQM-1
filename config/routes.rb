JQM1::Application.routes.draw do

  resources :settings_nr4s

      get "/nr4/genres/show_log"
      #get "genres/show_log"
      
  # Matches
  #match "/keywords" => redirect ("/nr4/keywords") #=> syntax error, unexpected tLPAREN_ARG
  #post "/keywords", to: redirect('/nr4/keywords')
  #post "/nr4/keywords/create"
  #post "/keywords", to: redirect('/nr4/keywords/create')
  
  resources :keywords, module: 'nr4'

  resources :categories

  resources :key_word_sets

  resources :genres

  resources :articles

  get "twitter_app/main"

  get "twitter_app/sub1"

  get "twitter_app/sub2"

  resources :settings

  root :to => 'admin#main'
  
  get "admin/main"
  get "admin/m_main"

  get "admin/sub1"

  get "admin/sub2"


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
     namespace :nr4 do
       # Directs /admin/products/* to Admin::ProductsController
       # (app/controllers/admin/products_controller.rb)
       resources :settings_nr4s, :articles, :genres, :categories, :keywords
     end
     
     # Scopes
     #REF http://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing
     #scope module: 'nr4' do
     #       resources :keywords
     #end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
