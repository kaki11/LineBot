Rails.application.routes.draw do
  get 'sessions/new'
  root 'home#index'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  get '/index' => 'home#index'
  post '/callback' => 'linebot#callback'
end
