CpcadvApp::Application.routes.draw do
  
  get "credits_withdraw/list"

  get "visitor_tracker/track"

  resources :payment_notifications

  get "share_offer/CreateLink"

  resources :offers

  resources :categories

 # get "members" => "home#index"
 

 
  #get "offers" => "home#index"
  resources :members

  #match "admin/index" => "AdminUser#index", :as => "admin/dashboard"
  
  #g 'admin/dashboard', to: 'AdminUser#index'
  
  
  get "admin/dashboard" => "AdminUser#index"
  #get 'admin/offers' => 'offers#index' 
  get "admin/members" => "members#index"
  
  
  
  
  
   post "topup" => "offers#topup"
  
  post "login" => "home#login"
  
  post "updateMemberDetail" =>"members#updateMemberDetail"
  post "updateMemberSettings" =>"members#updateMemberSettings"
  
  get "sign_up" => "members#new", :as => "sign_up"


    #get "admin_user/index" => "AdminUser#index", :as => "admin/index"
  #post "admin_user/index" => "AdminUser#index", :as => "admin/index"

  get "/:member_random_code/:random_code" =>"visitor_tracker#track"
  
  
  post "members/:id" => "Members#banuser"
  
  post "offers/:id" => "Offers#approverejectoffer"
  
  post "credits_withdraw/:id" => "credits_withdraw#updateCreditStatus"
  
  
  
  
  post "offers/os/:id" => "Offers#stopoffer"
  

  #get "admin_user/logout"

  #get "admin_user/change_password"

  #get "admin_user/forgot_password"

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  match 'myOffers', to: 'offers#myOffers', as: 'myOffers'
  match 'mySettings', to: 'members#mySettings', as: 'mySettings'
  match 'withDrawCash', to: 'members#withDrawCash', as: 'withDrawCash'
  match 'promoteOffers', to: 'offers#promoteAndSortOffers', as: 'promoteOffers'
  match 'sortOffers/:sort_by', to: 'offers#promoteAndSortOffers', as: 'sortOffers'
  match 'sortOffers/:sort_by/:category_id', to: 'offers#promoteAndSortOffers', as: 'sortOffers'
  match 'offerPayment/:offer_id', to: 'offers#offerPayment', as: 'offerPayment'
  match 'promoteOffers1', to: 'offers#promoteOffers1', as: 'promoteOffers1'
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
  
    
  get "log_out" => "AdminUser#logout"#, :as => "log_out"
 
 



  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
