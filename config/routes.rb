Rails.application.routes.draw do
  
  devise_for :users

  root 'pages#home'

  get 'chatroom', to: 'chatroom#index', as: 'chatroom'

  get 'my_friends', to: 'friendships#index', as: 'my_friends'
  get 'search_friends', to: 'friendships#search', as: 'search_friends'
  post 'friendships', to: 'friendships#create'
  patch 'friendships/:id', to: 'friendships#update', as: 'update_friendship'
  delete 'friendships/:id', to: 'friendships#destroy', as: 'friendship'
end
