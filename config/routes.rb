Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks, except: :destroy
end
