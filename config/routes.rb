Rails.application.routes.draw do
  root 'kazoo#index'
  get '/graph' => 'graph#index'

  resources :kazoos, only: [:index]
  get '/kazoo' => 'kazoo#show'
end
