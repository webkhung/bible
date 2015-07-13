Rails.application.routes.draw do
  resources :high_scores

  get 'verses' => 'page#verses'
  get 'finished' => 'page#finished'
  get 'answered' => 'page#answered'
  get 'usage' => 'page#usage'
  get 'report' => 'page#report'
  get 'users' => 'page#users'
  get 'bg_rating' => 'page#bg_rating'
  get 'users_count' => 'page#users_count'
  get 'delete_users' => 'page#delete_users'
  get 'memorized_verses' => 'page#memorized_verses'
  get 'memorized_stats' => 'page#memorized_stats'
  get 'memorized_verses_with_count' => 'page#memorized_verses_with_count'
  get 'memorized_stats_weekly' => 'page#memorized_stats_weekly'
  get 'menu' => 'page#menu'



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
