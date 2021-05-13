Rails.application.routes.draw do

  devise_for :users
  root to: 'posts#index'
    resources :posts do
    resources :comments,only:[:create, :destroy]
    resource :favorites,only:[:create, :destroy]
    get :search, on: :collection
  end
  resources :users, only: [:show, :edit, :update]
end
