Rails.application.routes.draw do
  devise_for :users

  root 'chatroom#index'
end
