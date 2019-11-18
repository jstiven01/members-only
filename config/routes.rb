Rails.application.routes.draw do
  root   'static_pages#home'
  get    '/signin',   to: 'sessions#new'
  post   '/signin',   to: 'sessions#create'
  delete '/signout',  to: 'sessions#destroy'
  get  '/signup',     to: 'users#new'
  post '/signup',     to: 'users#create'
  resources :posts,     only: [:new, :create, :index]
  resources :users
end
