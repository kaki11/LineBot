Rails.application.routes.draw do
  get 'users/new'
  root 'home#index'
  get '/index' => 'home#index'
  post '/callback' => 'linebot#callback'
end
