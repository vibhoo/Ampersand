Socialrails::Application.routes.draw do

  root :to => 'static_pages#home'

  resources :users do
    member do
      get :following, :followers
    end
  end

  match '/signup' => 'users#new'

  resources :relationships, :only => [:create, :destroy]
  resources :microposts, :only => [:create, :destroy] do
    member do
      get :likes, :fans
    end
  end
  resources :opinions, :only => [:create, :destroy]
  resources :messages, :only => [:create]
  resources :sessions, :only => [:new, :create, :destroy]

  match '/signin' => 'sessions#new'
  match '/signout' => 'sessions#destroy', :via => :delete

  match '/updates' => 'static_pages#updates'
  match '/about' => 'static_pages#about'
  match '/contact' => 'static_pages#contact'
  match '/connect' => 'static_pages#connect'
end
