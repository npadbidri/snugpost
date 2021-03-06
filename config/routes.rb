Snugpost::Application.routes.draw do
  devise_for :users

  #resources :posts

  #resources :links
  #resources :admins
  match 'admin' => 'admins#index'  
  match 'login' => 'adminlogin#index'
  match 'login/auth' => 'adminlogin#auth'
  match 'links'=>'links#index'
  match 'posts/delete'=>'posts#delete'
  match 'links/accept' => 'links#accept'
  match 'links/parse' => 'links#parse'
  match 'links/new' => 'links#new'
  match 'links/create' => 'links#create'
  match 'admins/account' => 'admins#account'
  match 'admins/logout' => 'admins#logout'
  match 'admins/account' => 'admins#account'
  match 'admins/saveaccount' => 'admins#saveaccount'
  match 'admins/show' => 'admins#show'
  match 'admins/edit' => 'admins#edit'
  match 'admins/destroy' => 'admins#destroy'
  match 'admins/update' => 'admins#update'
  match 'admins/new' => 'admins#new'
  match 'admins/create' => 'admins#create'
  match 'posts'=>'posts#index'
  match 'admins/administrators' => 'admins#administrators'
  match 'adminlogin/auth' => 'adminlogin#auth'
  match 'search'=>'search#index'
  match 'contact'=>'contact#index'
  match 'contact/send'=>'contact#sendemail'
  #match "admins/:name" => "admins#%{name}"
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
  # root :to => "welcome#index"
  root :to => "site#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
