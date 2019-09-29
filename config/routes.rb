Rails.application.routes.draw do
  root 'home#index'
  resources :users
  get '/index' => 'home#index'
  post '/callback' => 'linebot#callback'
end
