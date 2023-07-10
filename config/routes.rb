Rails.application.routes.draw do
  root 'lyrics#index'
  resources :lyrics, only: [:new, :create, :edit, :update, :destroy, :show]
end
