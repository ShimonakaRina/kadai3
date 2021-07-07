Rails.application.routes.draw do
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  get 'user/:user_id/followers' => 'relationships#followers', as: 'user_followers'
  get 'user/:user_id/followings' => 'relationships#followings', as: 'user_followings'
  get '/search' => 'search#search'
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  devise_for :users
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update]

end
