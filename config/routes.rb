Bloccit::Application.routes.draw do
 

  devise_for :users
    resources :topics do
    resources :posts, except: [:index]
    resources :summary
    end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
