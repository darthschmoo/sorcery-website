Sorcery::Application.routes.draw do
  namespace :publicity do 
    resources :reviewers do
      collection do
        get 'index'
      end
      
      member do
        get 'new_submission'
        post 'submitted_for_review'
      end
    end
  end

  resources :authors do
    resources :social_media_links do
      collection do
        get 'index'
      end
    end
  end
  
  resources :stories
  resources :pages 
  resources :books
  resources :book_reviews do
    match 'test' => 'book_reviews#test'
  end
  
  resources :book_submissions do
    member do
      get 'download'  
    end  
  end
  
  resources :tweet_quotes
  
  # hard-coding to the first author for now.
  match 'author' => 'authors#show', :id => 1



  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # match 'login/:passkey' => 'simple_login#login'
  # match 'logout' => 'simple_login#logout'

  
  resources :author_sessions
  
  match 'login' => "author_sessions#new"
  match 'logout' => "author_sessions#destroy"
  # map.root :controller => "author_sessions", :action => "new" # optional, this just sets the root route

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
  
  root :to => 'pages#show', :slug => "/"
  match "*slug" => "pages#show"
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
