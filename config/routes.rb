Rails.application.routes.draw do
  post 'versions/:id/revert', to: 'versions#revert', as: 'revert_version'
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'feedback', to: 'pages#feedback'
  resources :declarations
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :comments
end
