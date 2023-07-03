Rails.application.routes.draw do
  root to: redirect('/categories', status: 302)
  resources :purchases
  resources :categories
  resources :users
end
