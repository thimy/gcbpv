Rails.application.routes.draw do
  get "association", to: "association#index"
  get "bogue", to: "bogue#index"

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
  get "ecole/tarifs", to: "ecole#pricing", as: :pricing
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
    resources :stats, only: [:index]
    resources :fiches_profs, only: [:index, :show]
    resources :payors
    resources :students
    resources :subscription_groups
    resources :subscriptions
    resources :teachers
    resources :slots, only: [:show, :edit, :destroy]
    resources :workshops
    resources :workshop_slots, only: [:show]
    resources :kid_workshops
    resources :kid_workshop_slots, only: [:show]
    resources :trainings
    resources :projects
    resources :instruments
    resources :cities
    resources :plans
    resources :seasons
    resources :events
    resources :posts
    resources :editions
    resources :categories
    resources :administrators
    resources :configs, only: [:index, :show, :edit, :update]
    
    root to: "stats#index"
  end
  get "", to: "website#index", as: "/"
  get "contact", to: "website#contact", as: "/contact"
  get "bogue", to: "website#bogue"
  namespace :secretariat do
    resources :posts, path: "actualites" do
      post :upload_image, on: :collection, as: "secretariat_posts_upload_image"
      post :upload_file, on: :collection, as: "secretariat_posts_upload_file"
    end
    resources :teachers, path: "professeurs"
    # resources :students, path: "eleves"
    resources :subscriptions, path: "eleves" do
      post :add_course, on: :collection
      post :add_workshop, on: :collection
    end
    resources :kid_workshops, path: "enfance"
    resources :workshops, path: "ateliers"
    resources :courses, path: "cours"
    resources :subbed_workshops
    resources :subbed_kid_workshops
    resources :payors, path: "payeurs"
    resources :instruments, path: "disciplines"
    resources :emails do
      post :upload_file, on: :collection, as: "secretariat_emails_upload_file"
      post :send_email, path: "/send_email(.:format)", as: "secretariat_emails_send_email"
    end
  end  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "secretariat", to: "secretariat#index", as: "secretariat_root"

  get "get_teachers", to: "secretariat/instruments#get_teachers"
  get "get_slots", to: "secretariat/teachers#get_slots"
  get "get_workshop_slots", to: "secretariat/workshops#get_slots"
  get "get_kid_workshop_slots", to: "secretariat/kid_workshops#get_slots"

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
