Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :subscriptions
    resources :students
    resources :payors
    resources :workshops
    resources :instruments
    resources :teachers
    resources :slots
    resources :cities
    resources :plans
    resources :seasons
    resources :events
    resources :posts
    resources :categories
    resources :configurations, only: [:index, :show, :edit, :update]
    
    root to: "cities#index"
  end
  get "", to: "website#index", as: "/"
  scope :secretariat do
    resources :subscriptions
    resources :workshops
    resources :students
    resources :courses
    resources :slots
    resources :teachers
    resources :cities
    resources :payors
    resources :instruments
    get "", to: "secretariat#index", as: "/"
  end  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
