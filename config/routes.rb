Rails.application.routes.draw do
  post 'versions/:id/revert', to: 'versions#revert', as: 'revert_version'
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  resources :articles
end
