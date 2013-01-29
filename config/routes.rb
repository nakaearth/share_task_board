TaksBoard::Application.routes.draw do

  match "blog/*page" => "blog#respond"

  #user page
  get "top/index"
  get "/login" => "sessions#new",:as => :login
  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "sessions#failure"
  match "/logout" => "sessions#destroy"
  get "users/search_user"
  get "users/set_user"

  #report page
  resources :reports, :only=>[:index] do
    collection do
      post 'calculate_job_count'
      post 'print_out'
    end
  end
  #Job page
  resources :jobs ,:only=>[:index, :show, :new, :create, :update, :edit] do
     member do
       get 'update_status'
       get 'receive_task'
     end
     collection do
       get 'finish_list'
       get 'pending_list'
      get 'receive_task_list'
      post 'my_group_job_list'
      post 'group_all_jobs'
    end
  end
  match	"/jobs/:id/destroy_task"=>"jobs#destroy_task"

  #group page
  resources :groups ,:only=>[:index, :show, :new, :create, :update, :edit, :destroy] do
    resources :users do
      collection do
        post 'search_user'
        get 'set_user' 
      end
    end
  end
  resources :profile ,:only=>[:show] do
    member do
      get 'setting'
      post 'update_profile'
    end 
  end

  #admin
  namespace :admin do
    resources :jobs ,:only=>[:index,:edit,:update] do
    end
    resources :users, :only=>[:index] do end
    resources :blog_template
  end

  #api
  namespace :api do
    resources :jobs, :only=>[:save, :update, :show] do
      member do
        get 'delete'
      end
      collection do 
        get 'my_list'
      end
    end
  end

#  get 'jobs' ,:to=>'jobs#index', :as => :user_root
  
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
  root :to => 'top#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
