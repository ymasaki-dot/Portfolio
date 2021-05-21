Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
    resources :posts do
    resources :comments,only:[:create, :destroy]
    resource :favorites,only:[:create, :destroy]
    get :search, on: :collection
  end
  resources :users, only: [:show, :edit, :update]
  get   'inquiry'         => 'inquiry#index'     # 入力画面
  post  'inquiry/confirm' => 'inquiry#confirm'   # 確認画面
  post  'inquiry/thanks'  => 'inquiry#thanks'    # 送信完了画面
end
