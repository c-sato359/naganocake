Rails.application.routes.draw do
patch 'customers' => "public/customers#update"

devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
 scope module: :public do
    get '/about', to: 'homes#about'
   # get 'homes/top', to: 'customers#new'
    root to: 'homes#top'
    get 'customers/my_page' => "customers#show"
    get 'customers/edit/my_page' => "customers#edit"
   # resources :customers
    get '/customers/unsubscribe', to: 'customers#unsubscribe'
    patch '/customers/withdraw', to: 'customers#withdraw'
    resources :items, only: [:show, :index]
    resources :cart_items
    #get '/orders/thanks' =>'orders#thanks'
    post '/orders/confirm', to: 'orders#confirm'
    #get 'orders/:id', to: 'orders#complete'
    get '/orders/thanks', to: 'orders#thanks'
    resources :orders
    #get '/orders/confirm', to: 'orders#confirm'
    get 'orders/:id', to: 'orders#complete'
    delete "all_destroy" => "cart_items#all_destroy",as: "customers_all_destroy"
    resources :addresses
  end
  namespace :admin do
    get 'homes/top'
  end
  #devise_for :admins

  resources :cart, only: [:show]
  resources :charge, only: [:create]


  namespace :admin do
    resources :items
    resources :genres
    #get 'customers/index'
    #get 'customers/show'
    #get 'customers/:id/edit'
    resources :customers, only: [:show, :index, :update, :edit]
#get 'orders/:id/show'
    #post '/orders/order_detail', to: 'orders#details'
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:show, :update]
  end

    #scope module: :public do
    #  get '/about', to: 'homes#about'

    #  resources :items, only: [:show, :index]
     # resources :add_to_carts, only: [:create]
      #resources :delete_in_carts, only: [:create]
    #end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end