Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, only: [:create]  # Add nested comments resource under posts
  end
  root 'posts#index'
end
