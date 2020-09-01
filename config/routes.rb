Rails.application.routes.draw do
  root 'tasks#index'
  get '/login', to: 'sessions#new'
  resources :tasks
end
