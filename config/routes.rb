Rails.application.routes.draw do
  root to: redirect('/categories', status: 302)
  resources :categories
  resources :users
end
