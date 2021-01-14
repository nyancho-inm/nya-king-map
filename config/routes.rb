Rails.application.routes.draw do
  devise_for :users
  root to: 'cats#index'
  resources :cats
end
