Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users
  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end
  root "users#index"
  resources :users, only: [:index, :show] do 
    resources :posts, only: [:index, :show, :create, :new] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end
end
