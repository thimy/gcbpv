Rails.application.routes.draw do
  get "403", to: "errors#forbidden", as: :forbidden
  get "404", to: "errors#not_found", as: :not_found
  get "500", to: "errors#internal_error", as: :internal_error
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
  get "ecole/calendrier", to: "ecole#calendar", as: :calendar
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
    resources :households
    resources :students
    resources :subscription_groups
    resources :subscriptions
    resources :teachers
    resources :slots
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
    resources :price_categories
    resources :seasons
    resources :editions
    resources :categories
    resources :administrators
    resources :configs, only: [:index, :show, :edit, :update]
    resources :users
    
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
      post :upload_file, on: :collection, as: "upload_file"
      post :send_email, path: "/send_email(.:format)", as: "emails_send_email"
    end
    resources :events, path: "evenements" do
      post :upload_file, on: :collection, as: "upload_file"
    end
    resources :instruments, path: "disciplines"
    resources :kid_workshops, path: "enfance"
    resources :payments
    resources :households, path: "foyers"
    resources :posts, path: "actualites" do
      post :upload_file, on: :collection, as: "upload_file"
    end
    resources :slots, path: "creneaux"
    resources :subscriptions do
      get :edit_subscription, to: "subscriptions#edit_subscription"
      get :show_subscription, to: "subscriptions#show_subscription"
    end
    resources :subscription_groups do
      get :edit_discount, to: "subscription_groups#edit_discount"
      get :edit_donation, to: "subscription_groups#edit_donation"
      get :show_summary, to: "subscription_groups#show_summary"
      get :show_info, to: "subscription_groups#show_info"
      get :edit_subscription_group, to: "subscription_groups#edit_subscription_group"
      get :show_subscription_group, to: "subscription_groups#show_subscription_group"
    end
    resources :subbed_kid_workshops
    resources :subbed_workshops
    resources :teachers, path: "professeurs" do
      post :add_course, on: :collection
      post :add_workshop, on: :collection
    end
    resources :workshops, path: "ateliers" do
      resources :workshop_slots, controller: "workshop_slots", path: "creneaux"
    end
    resources :projects, path: "projets" do
      post :upload_file, on: :collection, as: "upload_file"
    end
    resources :trainings, path: "thematiques" do
      post :upload_file, on: :collection, as: "upload_file"
      resources :training_sessions, controller: "trainings/training_sessions", path: "rendez-vous" do
        post :upload_file, on: :collection, as: "upload_file"
      end
    end
    resource :courses, path: "cours" do
      get :edit_time, to: "courses#edit_time"
      get :show_time, to: "courses#show_time"
    end

    scope path: ":season_name", as: :season do
      resources :instruments, path: "disciplines"
      resources :kid_workshops, path: "enfance"
      resources :workshops, path: "ateliers"
      resources :households, path: "foyers"
      resources :slots, path: "creneaux"
      resources :students, path: "eleves"
      resources :teachers, path: "professeurs"
    end

    resources :students
  end  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "secretariat", to: "secretariat#index", as: "secretariat_root"

  get "get_teachers", to: "instruments#get_teachers"
  get "get_slots", to: "teachers#get_slots"
  get "get_workshop_slots", to: "workshops#get_slots"

  get :subscription_new_workshop, to: "subscriptions#new_workshop"

  get :edit_personal_info, to: "students#edit_personal_info"
  get :show_personal_info, to: "students#show_personal_info"

  get :edit_household_info, to: "households#edit_personal_info"
  get :show_household_info, to: "households#show_personal_info"

  namespace :users, as: "account", path: "compte" do
    resources :courses, path: "cours"
    resources :subbed_kid_workshops
    resources :subbed_workshops
    resources :students, path: "eleves"
    resources :subscriptions, path: "inscriptions"
    resources :subscription_groups, only: [:update]
    resources :households, path: "foyer"
  end
  get "compte", to: "users#index", as: "account_root"
  get "compte/validation", to: "users#validation", as: "account_validation"

  namespace :profs do
    get "", to: redirect("/profs/#{Config.first.season.name}")
    get "profil", to: "profile"
    patch :update, to: "update"

    scope path: ":season_name", as: :season do
      root "index"
      resources :students, path: "eleves", only: [:show]
    end
  end

  # resources :events, path: :evenements, only: [:index, :show]
  resources :courses
  resources :slots
  resources :teachers
  resources :cities
  resources :households
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
