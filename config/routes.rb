Rails.application.routes.draw do
  devise_for :users
  resources :posts
  root 'posts#index'
  # root to: 'devise/registrations#new'

end
