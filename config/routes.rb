Rails.application.routes.draw do

  resources :users, except: [:index]
  root to: 'users#new'
  get 'sessions/new' => 'sessions#new', as: 'login_form'
  post 'sessions/create' => 'sessions#create', as: 'login'
  get 'sessions/destroy' => 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create_from_omniauth'
  get 'auth/failure' => 'sessions#new'

  get 'home' => 'room#home'
  get 'start' => 'room#start'
  get 'flop' => 'room#flop'
  get 'turn' => 'room#turn'
  get 'river' => 'room#river'
  get 'check' => 'room#check'
end
