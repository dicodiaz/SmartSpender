Rails.application.routes.draw do
  devise_for :users
  root to: redirect('/categories', status: 302)
  resources :purchase_categories
  resources :purchases
  resources :categories
  resources :users
end
