Rails.application.routes.draw do
  devise_for :users
  # Favicon route to use existing public icon
  get '/favicon.ico', to: redirect('/icon.png')

  # Switch user functionality
  post '/switch_user', to: 'sessions#switch_user'

  # User management routes (constrained to avoid Devise conflicts)
  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy], constraints: { id: /\d+/ }
  resources :companies
  resources :projects
  resources :workers do
    resources :bank_details, except: [:index]
  end
  resources :bank_details, only: [:index, :show, :edit, :update, :destroy]
  resources :teams
  resources :team_heads
  resources :attendances do
    member do
      patch :approve
    end
  end
  resources :stocks
  resources :daily_updates do
    member do
      patch :approve
    end
    resources :replies, only: [:index, :create, :destroy]
  end

  # API Access Management
  resources :api_accesses

  # API routes
  namespace :api do
    namespace :v1 do
      resources :attendances, only: [:index, :show, :update]
      resources :companies, only: [:index, :show, :update]
      resources :projects, only: [:index, :show, :update]
      resources :workers, only: [:index, :show, :update]
      resources :stocks, only: [:index, :show, :update]
      resources :daily_updates, only: [:index, :show, :update]
      resources :bank_details, only: [:index, :show, :update]
      resources :teams, only: [:index, :show, :update]
      resources :team_heads, only: [:index, :show, :update]
      resources :users, only: [:index, :show, :update]
      resources :replies, only: [:index, :show, :update]
    end
  end

  root 'home#index' # Or a dashboard page
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
