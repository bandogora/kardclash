Rails.application.routes.draw do
  post 'versions/:id/revert', to: 'versions#revert', as: 'revert_version'
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles
end
