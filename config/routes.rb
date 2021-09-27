Rails.application.routes.draw do
  root "posts#index"
  resources :posts
  get "users/:id", to: "users#show"
  devise_for :users
end
