Rails.application.routes.draw do
  resources :users, except: [:index]
  root to: 'users#new'
  get 'sessions/new' => 'sessions#new', as: 'login_form'
  post 'sessions/create' => 'sessions#create', as: 'login'
  get 'sessions/destroy' => 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create_from_omniauth'
  get 'auth/failure' => 'sessions#new'

  mount ActionCable.server => '/cable'
end
