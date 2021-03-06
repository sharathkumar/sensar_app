SensarApp::Application.routes.draw do

  # constraints subdomain: 'api' do
  #  scope module: 'api' do
  #    namespace :v1 do
  #      devise_for :users, controllers: { registrations: 'api/v1/users/registrations',
  #                                  sessions: 'api/v1/users/sessions',
  #                                  confirmations: 'users/confirmations',
  #                                  passwords: 'users/passwords' }
  #      resources :home
  #      resources :beacons
  #    end
  #  end
  # end

  # namespace :api, defaults: {format: :json} do
  namespace :api do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
      devise_scope :user do
        match '/sign_in' => 'users/sessions#create', :via => :post
        match '/sign_out' => 'users/sessions#destroy', :via => :post
        match '/sign_up' => 'users/registrations#create', :via => :post
        match '/forgot_password' => 'users/passwords#create', :via => :post
        match '/reset_password' => 'users/passwords#update', :via => :post
        match '/confirm_accout' => 'users/confirmations#show', :via => :get
        match '/resent_confirmation' => 'users/confirmations#create', :via => :post
      end
      match '/beacon_details' => 'beacons#show', :via => :post

      post '/create_social_profile' => 'social_profiles#create'
      post '/update_social_profile/:id' => 'social_profiles#update'
      post '/delete_social_profile/:id' => 'social_profiles#delete'
      get '/view_social_profile/:id' => 'social_profiles#show'

      post '/create_business_profile' => 'business_profiles#create'
      post '/update_business_profile/:id' => 'business_profiles#update'
      post '/delete_business_profile/:id' => 'business_profiles#delete'
      get '/view_business_profile/:id' => 'business_profiles#show'

      post 'picture_upload' => 'social_profiles#upload'
    end
  end


  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions',
                                    confirmations: 'users/confirmations',
                                    passwords: 'users/passwords' }
  root to: "home#index"
  resources :home
  resources :beacons
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
