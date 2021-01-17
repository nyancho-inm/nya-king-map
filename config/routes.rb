Rails.application.routes.draw do
  get 'comments/new'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  root to: 'cats#index'
  resources :cats do
    resources :comments, only: [:create, :destroy, ]
    collection do
      get 'search'
    end
  end
end
