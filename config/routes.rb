KnockIt::Application.routes.draw do
 
devise_for :users

resources :users, only: [:update, :show, :index]

resources :posts, only: [:index]

resources :topics do
  resources :posts, except: [:index], controller: 'topics/posts' do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    post '/up_vote' => 'votes#up_vote', as: :up_vote
    post '/down_vote' => 'votes#down_vote', as: :down_vote
  end
end

get 'about' => 'welcome#about'

root to: 'welcome#index'
end
