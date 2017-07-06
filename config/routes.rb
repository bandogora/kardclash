Rails.application.routes.draw do
  post 'versions/:id/revert', to: 'versions#revert', as: 'revert_version'
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'feedback', to: 'pages#feedback'
  get 'archives', to: 'pages#archives'
  get 'market', to: 'pages#market'
  get 'search', to: 'search#results'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :declarations
  resources :users, except: [:new]
  resources :comments
end
