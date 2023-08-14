Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  root 'homes#index'
  resources :homes, only: :index

  get '/lyrics/ranking', to: 'lyrics#ranking'
  resources :lyrics, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    resources :comments, only: [:create, :destroy, :edit, :update]
  end

  resources :users, only: [:show] do
    member do
      get :favorites, to: 'users#show_favorites', as: 'user_favorites'
      get :show_followers
      get :show_following
    end
  end

  post '/users/guest_sign_in', to: 'users#guest_sign_in'
  post '/users/guest_admin_sign_in', to: 'users#guest_admin_sign_in'

  resources :favorites, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: :index

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
