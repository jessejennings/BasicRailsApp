Bloccit::Application.routes.draw do
 

  get 'comments/new'

  get 'comments/show'

  get 'comments/index'

  devise_for :users
    resources :users, only: [:update]
      resources :topics do
        resources :posts, except: [:index] do
          resources :comments, only: [:create, :destroy]
    end
   end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
