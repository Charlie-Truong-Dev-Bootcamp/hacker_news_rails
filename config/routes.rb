HackerNews::Application.routes.draw do
  root 'posts#index'

  resources :users, only: [:new, :create, :show] do
    resources :comments, only: [:index]
    resources :posts, only: [:index]
  end



  resources :posts, only:[:new, :index, :create] do
    resources :votes, only: [:create]
    resources :comments, only: [:create, :index]
  end

  resources :sessions, only:[:new, :create, :delete]
end
