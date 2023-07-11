Rails.application.routes.draw do
  root 'lyrics#index'
  resources :lyrics, only: [:new, :create, :edit, :update, :destroy, :show]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
