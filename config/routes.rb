Rails.application.routes.draw do

  namespace :public do
    get '/about', to: 'homes#about'
    get 'homes/top'
    resources :customers
    resources :items, only: [:show, :index]
    resources :cart_items
    resources :orders
    resources :delete_in_carts, only: [:create]
#resources :items, only:[:show, :index]
 #   resources :homes, only:[:index]
   get '/orders/thanks' =>'orders#thanks'
  end
  namespace :public do
    #get 'addresses/index'
    #get 'addresses/edit'
    resources :addresses
  end
  namespace :admin do
    get 'homes/top'
  end
  #devise_for :admins
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  resources :cart, only: [:show]
  resources :charge, only: [:create]

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  namespace :admin do
    resources :items
    resources :genres
  end
  namespace :admin do
    #get 'customers/index'
    #get 'customers/show'
    #get 'customers/:id/edit'
    resource :customers, only: [:show, :index, :update, :edit]
  end
  namespace :admin do
#get 'orders/:id/show'
    resources :orders, only: [:show]
  end

    scope module: :public do
    #  get '/about', to: 'homes#about'

    #  resources :items, only: [:show, :index]
     # resources :add_to_carts, only: [:create]
      #resources :delete_in_carts, only: [:create]
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end