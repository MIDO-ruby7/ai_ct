Rails.application.routes.draw do
  root to: 'chat#index'
  resources :chats, only: [:new, :create]
end
