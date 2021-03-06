Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  root to: 'cats#index'
  resources :cats do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  get 'comments/new'
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  get '/cat/prefecture', to: "cats#prefecture"
end
