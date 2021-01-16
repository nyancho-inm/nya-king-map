Rails.application.routes.draw do
  get 'comments/new'
  devise_for :users
  root to: 'cats#index'
  resources :cats do
    resources :comments, only: [:create]
  end
end
