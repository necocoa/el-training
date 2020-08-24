Rails.application.routes.draw do
  resources :tasks, only: %i[index show]
end
