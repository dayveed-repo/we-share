Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tweets#index'

  resources :tweets, only: [:create, :show, :index, :destroy, :new]
  resources :users, only: [:show]
  # resources :likes, only: [:create, :destroy]
  post '/like/:id', to: 'likes#like', as: 'like_tweet'
end
