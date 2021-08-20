Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users, only: [:index, :show, :edit, :update] do
    resources :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
end
