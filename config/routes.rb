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
end
