Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'lyrics#index'

  resources :lyrics, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    resources :comments, only: [:create, :destroy, :edit, :update]
  end

  resources :users, only: [:show] do
    member do
      post :favorites, to: 'users#show_favorites', as: 'user_favorites'
    end
  end

  resources :favorites, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
