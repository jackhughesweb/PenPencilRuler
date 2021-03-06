Penpencilruler::Application.routes.draw do

  get '/terms' => 'pages#terms'
  get '/privacy' => 'pages#privacy'
  get '/copyright' => 'pages#copyright'
  get '/feedback' => 'pages#feedback'
  get '/cookies' => 'pages#cookies'
  get '/suspended' => 'pages#suspended', as: 'suspended'

  devise_for :users, controllers: { registrations: "users/registrations"}

  devise_scope :user do
    get '/logout' => 'devise/sessions#destroy'
    get '/signup' => 'devise/registrations#new'
    get '/login' => 'devise/sessions#new'
    resource :registration,
    only: [:new, :create, :edit, :update],
    path: 'users',
    path_names: { new: 'sign_up' },
    controller: 'devise/registrations',
    as: :user_registration do
      get :cancel
    end
  end

  resources :search

  resources :subjects do
    resources :topics do
      resources :notes
    end
  end

  get '/admin' => 'admin#index', as: 'admin'
  get '/admin/users/search/:search' => 'admin#users', as: 'admin_userssearch'
  get '/admin/users(/:id)' => 'admin#users', as: 'admin_users'
  get '/admin/become/:id' => 'admin#become', as: 'admin_become'
  get '/admin/suspend/:id' => 'admin#suspend', as: 'admin_suspend'
  get '/admin/unsuspend/:id' => 'admin#unsuspend', as: 'admin_unsuspend'
  get '/admin/allowdeletion/:id' => 'admin#allowdeletion', as: 'admin_allowdeletion'
  get '/admin/preventdeletion/:id' => 'admin#preventdeletion', as: 'admin_preventdeletion'

  get '/admin/support' => redirect('https://secure.helpscout.net'), as: 'admin_support'
  get '/admin/newrelic' => redirect('https://rpm.newrelic.com'), as: 'admin_newrelic'
  get '/admin/postmarkapp' => redirect('https://postmarkapp.com'), as: 'admin_postmarkapp'

  root :to => 'pages#index'


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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
