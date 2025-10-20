Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'

  get 'chatrooms', to: 'chatroom#index', as: 'chatroom'
end
