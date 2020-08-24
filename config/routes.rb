Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks, only: %i[index show]
end
