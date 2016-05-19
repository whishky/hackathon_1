Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'events#start'

  get 'events/present_events' => 'events#_present_events'
  get 'events/past_events' => 'events#past_events'
  get 'events/future_events' => 'events#future_events'
  get 'events/search' => 'events#search'
  resources :events
  get 'events/show' => 'events#show'
  get 'events/new' => 'events#new'
  post 'events/new' => 'events#create'
  post 'events/create'
  get 'events/event_info/:id' => 'events#event_info'
  #get 'events/edit' => 'events#edit'
  post 'events/:id/edit' => 'events#update'
  #get '/events/search' => 'events#search', :as => "search"
  


  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'


  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  post 'events/event_info/:id' => 'comments#create'
  resources :comments,          only: [:create, :destroy, :edit, :update]

  get 'tags/:tag', to: 'events#show', as: "tag"
  
  namespace :api , :path => "", :defaults => {:format => :json} do
    namespace :v0 do
      get 'all_events' => 'event#show_all'
      get 'present_events' => 'event#present_events'
      get 'past_events' => 'event#past_events'
      get 'future_events' => 'event#future_events'
    end
  end

  #post '/events/:id/edit' => 'events#update'


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
