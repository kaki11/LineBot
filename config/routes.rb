Rails.application.routes.draw do
  root 'topics#index'
  post '/callback' => 'linebot#callback'
end
