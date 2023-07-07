Rails.application.routes.draw do
  root to: redirect('/categories', status: 302)
  resources :purchases, only: %i[index new create]
  resources :categories, only: %i[index new create]
  devise_for :users

  get '/welcome', to: 'users#welcome'
end
