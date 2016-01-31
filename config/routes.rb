Rails.application.routes.draw do
  root 'kazoo#index'
  devise_for :users
  get '/graph' => 'graph#index'

  resources :kazoos, only: [:index]
  get '/kazoo' => 'kazoo#show'
end
