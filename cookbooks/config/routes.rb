Cookbooks::Application.routes.draw do
  resources :purchase_books

  resources :cart_books do
  end 
  
  devise_for :users

  resources :carts do
    member do
      get :vaciar
      post :confirmar
    end
  end
  
  resources :books do
    collection do
      get :autocomplete_author_nombre
      get :autocomplete_editorial_nombre
      get :autocomplete_tag_nombre
      get :deshabilitados
    end
    
    member do
      get :habilitar
      post :add_to_cart
    end
  end

  resources :purchases do
    collection do
      get :mas_comprados
    end
  end

  resources :users do
    member do
      get 'cart'
      get 'purchases'
    end
  end

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
  get 'ayuda' => 'pages#ayuda'
  get 'nuevo_admin' => 'pages#nuevo_admin'
  post 'nuevo_admin' => 'pages#crear_admin'
  end
