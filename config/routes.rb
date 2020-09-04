Rails.application.routes.draw do
  root 'tasks#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  namespace :admin do
    resources :users do
      resources :tasks, only: :index
    end
  end
  resources :tasks do
    resources :task_labels, only: %i[create destroy]
  end
  resources :labels, only: %i[index create destroy]

  get '*path', to: 'application#routing_error'
end
