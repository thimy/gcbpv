Rails.application.routes.draw do
  resources :posts
  resources :events

  get "/events", to: "events#index"
  get "/events/:id", to: "events#show"

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  namespace :admin do
    resources :posts
    root to: "posts#index"

    resources :events
  end
  root "public#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
