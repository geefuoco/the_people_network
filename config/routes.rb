Rails.application.routes.draw do
  authenticate :user do 
    root "posts#index", as: "authenticated_root"
  end
  root "devise/sessions#new"
  devise_for :users, controllers: { registrations: :registrations, omniauth_callbacks: "callbacks"}
  resources :posts do 
    resources :comments, only: [:new, :create, :destroy]
    resources :likes, only: [:new, :create, :destroy]
  end
  resources :comments do
    resources :comments, only: [:new, :create, :destroy]
  end
  resources :friendships, only: [:create, :destroy]
  get "users/:id", to: "users#show", as: "user_path"

end
