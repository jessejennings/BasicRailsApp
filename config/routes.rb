Bloccit::Application.routes.draw do
 
devise_for :users

resources :users, only: [:update, :show, :index]

resources :topics do
  resources :posts, except: [:index], controller: 'topics/post'
end
  
resources :posts, only: [:index] do
  resources :comments, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  get '/up_vote' => 'votes#up_vote', as: :up_vote
  get '/down_vote' => 'votes#down_vote', as: :down_vote
end


get 'about' => 'welcome#about'

root to: 'welcome#index'
end
