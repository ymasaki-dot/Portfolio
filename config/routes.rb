Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'posts#index'
    resources :posts do
    resources :comments,only:[:create, :destroy]
    resource :favorites,only:[:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update]
end