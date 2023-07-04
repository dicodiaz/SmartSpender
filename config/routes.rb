Rails.application.routes.draw do
  root to: redirect('/categories', status: 302)
  resources :purchase_categories
  resources :purchases
  resources :categories
  devise_for :users

  get '/welcome', to: 'users#welcome'
end
