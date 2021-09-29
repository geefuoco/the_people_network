Rails.application.routes.draw do
  authenticate :user do 
    root "posts#index", as: "authenticated_root"
  end
  root "devise/sessions#new"
  devise_for :users
  resources :posts do 
    resources :comments
  end
  resources :comments do
    resources :comments
  end
  resources :friendships, only: [:create, :destroy]
  get "users/:id", to: "users#show", as: "user_path"

end
