Rails.application.routes.draw do
  namespace :account do
  end
  get "compte", to: "compte#index", as: :account
  namespace :compte do
    resources :students, path: "eleves"
    resources :subscriptions, path: "inscriptions" do
      post :add_course, on: :collection
      post :add_workshop, on: :collection
    end
  end

  namespace :archives do
    resources :editions, only: [:index, :show]
  end

  get "archives", to: "archives#index"
  resources :posts, path: :actualites, only: [:index, :show]
  namespace :ecole do
    resources :instruments, path: :cours, only: [:index, :show]
    resources :projects, path: :projets, only: [:index, :show]
    resources :teachers, path: :professeurs, only: [:index, :show]
    resources :trainings, path: "rendez-vous", only: [:index, :show]
    resources :training_sessions, path: "rendez-vous/seances", only: [:show]
    resources :workshops, path: :ateliers, only: [:index, :show]
    get "enfance", to: "youth#index", as: :youth
    get "adhesion", to: "membership#index", as: :membership
  end
  get "ecole", to: "ecole#index"
  
  devise_for :administrators, path: "admin", path_names: {
    sign_in: "connexion",
    sign_out: "deconnexion",
    password: "mot-de-passe",
    unlock: "deblocage",
  }

  devise_for :users, path: "", path_names: {
    sign_in: "connexion",
    sign_out: "deconnexion",
    password: "mot-de-passe",
    unlock: "deblocage",
    sign_up: "inscription"
  }

  namespace :admin do
    resources :subscription_groups
    resources :subscriptions
    resources :students
    resources :payors
    resources :workshops
    resources :trainings
    resources :projects
    resources :instruments
    resources :teachers
    resources :slots
    resources :kid_workshops
    resources :cities
    resources :plans
    resources :seasons
    resources :events
    resources :posts
    resources :editions
    resources :categories
    resources :administrators
    resources :configs, only: [:index, :show, :edit, :update]
    
    root to: "cities#index"
  end
  get "", to: "website#index", as: "/"
  get "bogue", to: "website#bogue"
  namespace :secretariat do
    get "", to: "secretariat#index", as: "/"
  end  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :subscriptions
  resources :workshops
  resources :students
  resources :courses
  resources :slots
  resources :teachers
  resources :cities
  resources :payors
  resources :instruments
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :events, path: :evenements, only: [:index, :show]

end
