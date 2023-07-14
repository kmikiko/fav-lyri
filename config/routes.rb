Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'lyrics#index'
  resources :lyrics, only: [:index, :new, :create, :edit, :update, :destroy, :show]
  resources :users, only: [:show]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
