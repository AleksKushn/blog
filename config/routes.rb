Rails.application.routes.draw do
  resources :tags
  resources :comments
  resources :posts
  resources :users
  get 'results', to: 'results#index', as: 'results'
  resources :sessions, :only => [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
