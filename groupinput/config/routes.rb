Rails.application.routes.draw do
  
  devise_for :users
  root to: "staticpages#index"
  resources :audiences do
    resources :textquestions
    resources :multiple_choice_questions
  end
  resources :clients
  resources :multiple_choice_responses, only: [:create]
  resources :multiple_choice_answers
  get '/audiencefromcode/:code/:token', to: 'audiences#code'
  get '/broadcast/:code', to: 'audiences#showbroadcast'
  get '/addclient/:code/:token', to: 'audiences#addclient'

  post '/setbroadcast/', to: 'audiences#setbroadcast'
  get '/stopbroadcast/:code', to: 'audiences#stopbroadcast'
  get '/pricing', to: 'staticpages#pricing'
  get '/socket', to: 'staticpages#socket'
  get '/responsecount/:id', to: 'multiple_choice_answers#responsecount'
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
