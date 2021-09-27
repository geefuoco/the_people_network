Rails.application.routes.draw do
  authenticate :user do 
    root "posts#index", as: "authenticated_root"
  end
  root "devise/sessions#new"
  devise_for :users
  resources :posts
  resources :friendships, only: [:create, :destroy]
  get "users/:id", to: "users#show"

end
