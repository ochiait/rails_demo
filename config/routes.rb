Rails.application.routes.draw do
  
  # device用コールバックAction
  devise_for :social_accounts, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  
  # ログアウト
  devise_scope :social_account do
    get 'sign_out', to: "sessions#destroy"
  end
  
  root "top#index"
  get  "top/profile"
  resources :users
  resources :posts
  
end
