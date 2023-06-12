Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :pages, only: [ :index ]

  resources :releases, only: [:new, :create, :show, :index] do
    resources :listings, only: [ :new, :create ]
    resources :favorites, :reviews, only: [ :new, :create ]
  end

  resources :listings do
    resources :orders, only: [ :new, :create ]
  end

  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end

  resources :ownerships, only: [ :index, :new, :create ]

  resources :listings, only: [ :index, :destroy, :show ]

  resources :orders, only: [ :show, :create, :index, :edit ]

  resources :favorites, only: [ :index, :update ]

end
