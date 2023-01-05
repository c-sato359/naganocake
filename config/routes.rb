Rails.application.routes.draw do

  namespace :pubilc do
    get 'items/show'
    get 'items/index'
  end
  namespace :public do
    get 'addresses/index'
    get 'addresses/edit'
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
    get 'genres/index'
    get 'genres/edit'
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :admin do
    get 'orders/show'
  end

    scope module: :public do
      get '/about', to: 'homes#about'

      get 'homes/top'
      resources :items, only: [:show, :index]
      resources :add_to_carts, only: [:create]
      resources :delete_in_carts, only: [:create]
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end