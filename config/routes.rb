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
  get "success", to: "orders#sucess"

  resources :pages, only: [ :index ]

  resources :releases, only: [:new, :create, :show, :index] do
    resources :listings, only: [ :new, :create ]
    resources :favorites, :reviews, only: [ :new, :create ]
    resources :ownerships, only: [ :new, :create ]
    resources :release_reviews, only: [ :new, :create ]
  end

  resources :listings do
    resources :orders, only: [ :new, :create ]
    resources :favorites, :reviews, only: [ :new, :create, :destroy ]
  end

  resources :orders, only: [:show, :create, :index, :edit, :destroy ] do
    resources :payments, only: :new
  end

  resources :ownerships, only: [ :index, :destroy ]

  resources :listings, only: [ :index, :destroy, :show ]

  resources :favorites, only: [ :index, :update, :destroy ]

  resources :release_reviews, only: [ :destroy ]

end
