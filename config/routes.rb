Rails.application.routes.draw do
  
  #devise_for :admins
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'}
  
  #resources :cart, only: [:show]
  #resources :charge, only: [:create]
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"}
 
  root "items#index"
 # resources :items, only: [:show] do
    #scope module: :items do
     # resources :add_to_carts, only: [:create]
      #resources :delete_in_carts, only: [:create]
    #end
       #resources :items, only: [:new, :create]
  #end# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
