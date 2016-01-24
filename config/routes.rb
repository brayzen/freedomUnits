Rails.application.routes.draw do
  get '/graph' => 'graph#index'

  resources :kazoos, only: [:index]
  get '/kazoo' => 'kazoo#show'
  root 'kazoo#index'
end
