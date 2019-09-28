Rails.application.routes.draw do
  root 'home#index'
  get '/index' => 'home#index'
  post '/callback' => 'linebot#callback'
end
