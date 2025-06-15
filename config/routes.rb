Rails.application.routes.draw do
  resources :events, controller: "website/events", path: "evenements", as: "website_event"
  resources :posts, controller: "website/posts", path: "actualites", as: "website_post"
  get "association", to: "association#index"

  namespace :archives do
    resources :editions, only: [:index, :show]
  end

  get "archives", to: "archives#index"
  # resources :posts, path: :actualites, only: [:index, :show]
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
    resources :subscriptions, only: [:show, :edit, :destroy]
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
    resources :agglomerations
    resources :plans
    resources :seasons
    resources :editions
    resources :categories
    resources :administrators
    resources :configs, only: [:index, :show, :edit, :update]
    
    root to: "stats#index"
  end

  get "", to: "website#index", as: "/"
  get "contact", to: "website#contact", as: "/contact"
  
  resources :courses
  resources :subbed_kid_workshops
  resources :subbed_workshops

  scope "/secretariat" do
    resources :bogues, on: :collection do
      post :upload_file, on: :collection, as: "upload_file"
      resources :events, controller: "bogues/events", path: "evenements"
      resources :pages, controller: "bogues/pages"
    end
    resources :categories, on: :collection
    resources :emails do
      post :upload_file, on: :collection, as: "emails_upload_file"
      post :send_email, path: "/send_email(.:format)", as: "emails_send_email"
    end
    resources :events, path: "evenements" do
      post :upload_file, on: :collection, as: "events_upload_file"
    end
    resources :instruments, path: "disciplines"
    resources :kid_workshops, path: "enfance"
    resources :payments
    resources :payors, on: :collection, path: "foyers"
    resources :posts, path: "actualites" do
      post :upload_file, on: :collection, as: "posts_upload_file"
    end
    resources :slots, path: "creneaux"
    resources :students
    resources :subbed_kid_workshops
    resources :subbed_workshops
    resources :teachers, path: "professeurs" do
      post :add_course, on: :collection
      post :add_workshop, on: :collection
    end
    resources :workshops, path: "ateliers"

    scope path: ":season_name", as: :season do
      resources :instruments, path: "disciplines"
      resources :kid_workshops, path: "enfance"
      resources :payors, on: :collection, path: "foyers"
      resources :slots, path: "creneaux"
      resources :students
      resources :subscriptions, path: "eleves"
      resources :teachers, path: "professeurs"
    end
  end  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "secretariat", to: "secretariat#index", as: "secretariat_root"

  get "get_teachers", to: "instruments#get_teachers"
  get "get_slots", to: "teachers#get_slots"
  get "get_workshop_slots", to: "workshops#get_slots"
  get "get_kid_workshop_slots", to: "kid_workshops#get_slots"

  resources :subscriptions
  resources :workshops

  namespace :users, as: "account", path: "compte" do
    resources :courses, path: "cours"
    resources :subbed_kid_workshops
    resources :subbed_workshops
    resources :students, path: "eleves"
    resources :subscriptions, path: "inscriptions"
    resources :payors, path: "foyer"
  end
  get "compte", to: "users#index", as: "account_root"

  # resources :events, path: :evenements, only: [:index, :show]
  resources :courses
  resources :slots
  resources :teachers
  resources :cities
  resources :payors
  resources :instruments
  resource "bogue/:bogue_slug", controller: "website/bogue", only: [:show], as: "website_bogue" do
    get "temps-forts", to: "highlights", as: "highlights"
    get "programmation", to: "schedule"
    get "programmation/:event_slug", to: "event", as: "programmation_event"
    get "concours", to: "contests", as: "contests"
    get ":page_slug", to: "page", as: "page"
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
