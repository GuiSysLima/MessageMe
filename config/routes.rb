Rails.application.routes.draw do
  get 'messages/create'
  get 'private_messages/create'
  get 'conversations/index'
  get 'conversations/show'
  get 'conversations/create'
  
  devise_for :users

  root 'pages#home'

  get 'chatroom', to: 'chatroom#index', as: 'chatroom'

  get 'my_friends', to: 'friendships#index', as: 'my_friends'
  get 'search_friends', to: 'friendships#search', as: 'search_friends'
  post 'friendships', to: 'friendships#create'
  patch 'friendships/:id', to: 'friendships#update', as: 'update_friendship'
  delete 'friendships/:id', to: 'friendships#destroy', as: 'friendship'
  
  resources :conversations, only: [:index, :show, :create]
  resources :private_messages, only: [:create]
end
