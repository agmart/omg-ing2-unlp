Cookbooks::Application.routes.draw do
  devise_for :users
  resources :carts

  resources :books do
    get :autocomplete_author_nombre, :on => :collection
    get :autocomplete_editorial_nombre, :on => :collection  
  end

  resources :purchases

  resources :users

  resources :editorials

  resources :authors

  resources :tags


  root 'books#index'

  # Cuando alguien haga un get a estas páginas, va al controlador
  # de las páginas "genéricas" y muestra las vistas que corresponden
  # a esas acciones (por defecto las que tienen el mismo nombre)
  get 'acerca_de' => 'pages#acerca_de'
  get 'contacto' => 'pages#contacto'
  get 'administracion' => 'pages#administracion'

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
