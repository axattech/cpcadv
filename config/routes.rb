CpcadvApp::Application.routes.draw do

  get "admin/credits_withdraw/list" => "credits_withdraw#list"

  get "visitor_tracker/track"

  resources :payment_notifications

  get "share_offer/CreateLink"
  get "admin/offers" => "offers#index"
  get "/offers/new" =>"offers#new"
  post "/offers/create" =>"offers#create"
  get "/offers/promoteOffers" =>"offers#promoteAndSortOffers"
  get "/promoteOffers" =>"offers#promoteAndSortOffers"
  
  get "offers/:id/edit" => "offers#edit"
  
 put "offers/:id/edit" => "offers#update"
 
 post "/admin/offers/:id" => "offers#approverejectoffer"
 
 post "/admin/reoffers/:id" => "offers#reapproveoffer"
 
  #resources :offers

  #resources :categories




  # get "members" => "home#index"

  #get "offers" => "home#index"
  #resources :members

  get "admin/members" => "members#index"
  post "/members" => "members#create"
  post "/test" => "members#test"

  #match "admin/index" => "AdminUser#index", :as => "admin/dashboard"

  #g 'admin/dashboard', to: 'AdminUser#index'

  get "admin/dashboard" => "AdminUser#index"
  #get 'admin/offers' => 'offers#index'
  get "admin/members" => "members#index"
  
  post "/admin/members/:id" => "members#banuser"

  get "admin/categories" => "categories#index"
  get "admin/categories/new" => "categories#new"
  
  get "admin/categories/:id/edit" => "categories#edit"
  put "admin/categories/:id/edit" => "categories#update"
  delete "admin/categories/:id" => "categories#destroy"
  
  post "admin/categories/new" => "categories#create"
  
  put "admin/categories/new" => "categories#update"
  

  post "topup" => "offers#topup"

  post "login" => "home#login"

  post "updateMemberDetail" =>"members#updateMemberDetail"
  post "updateMemberSettings" =>"members#updateMemberSettings"

  get "sign_up" => "members#new", :as => "sign_up"
  get 'sortMyOffers/:qs/:sort_by/' =>'offers#sortMyOffers'

  #get "admin_user/index" => "AdminUser#index", :as => "admin/index"
  #post "admin_user/index" => "AdminUser#index", :as => "admin/index"

  get "/:member_random_code/:random_code" =>"visitor_tracker#track"
  get "mailverify" => "Members#mailverify"

  post "members/:id" => "Members#banuser"

  post "offers/:id" => "Offers#approverejectoffer"

  post "credits_withdraw/:id" => "credits_withdraw#updateCreditStatus"

  post "offers/os/:id" => "Offers#stopoffer"

  #get "admin_user/logout"

  #get "admin_user/change_password"

  #get "admin_user/forgot_password"

  match 'auth/:provider/callback', to: 'sessions#create'
  #match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  match 'myOffers', to: 'offers#myOffers', as: 'myOffers'
  match 'mySettings', to: 'members#mySettings', as: 'mySettings'
  match 'withDrawCash', to: 'members#withDrawCash', as: 'withDrawCash'
  
  match 'sortOffers/:sort_by', to: 'offers#promoteAndSortOffers', as: 'sortOffers'
  match 'sortOffers/:sort_by/:category_id', to: 'offers#promoteAndSortOffers', as: 'sortOffers'
  match 'offerPayment/:offer_id', to: 'offers#offerPayment', as: 'offerPayment'
 
  match 'login', to: 'home#loginPage', as: 'login'

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
  # just remember to delete public/index.html.
  root :to => 'home#index'

  #admin_root :to => 'AdminUser#index'

  get "admin" => "AdminUser#login"
  post  "admin" => "AdminUser#login"

  get "admin/log_out" => "AdminUser#logout"#, :as => "log_out"

# See how all your routes lay out with "rake routes"

# This is a legacy wild controller route that's not recommended for RESTful applications.
# Note: This route will make all actions in every controller accessible via GET requests.
# match ':controller(/:action(/:id))(.:format)'
end
