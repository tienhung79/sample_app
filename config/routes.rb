Rails.application.routes.draw do
  resources :products

  root "static_pages#home"
  get "static_pages/home"
  get "static_pages/help"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users

  get "/login", to: "session#new"
  post "/login", to: "session#create"
  delete "/logout", to: "session#destroy"

  get "/login", to: "session#new"
  post "/login", to: "session#create"
  delete "/logout", to: "session#destroy"

  resources :account_activations, only: :edit
  resources :password_resets, only: %i(new create edit update)

  resources :microposts, only: %i(create destroy)
  # or resources :microposts, except: %i(index new edit show update)

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: %i(create destroy)
end
