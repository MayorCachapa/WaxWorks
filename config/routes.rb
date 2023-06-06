Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :releases, only: [ :index, :show ]

  resources :ownerships, only: [ :index, :new, :create ]

  resources :listings, only: [ :index, :new, :create, :show ]

  resources :orders, only: [ :show, :create, :index ]

  resources :favorites, only: [ :index, :update ]

  resources :releases do
    resources :favorites, :reviews, only: [ :create ]
  end

  resources :listings do
    resources :orders, only: [ :create ]
  end
end
