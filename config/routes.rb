Rails.application.routes.draw do
  get 'comments/new'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'cats#index'
  resources :cats do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  get '/cat/prefecture', to: "cats#prefecture"
end
