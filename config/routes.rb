Rails.application.routes.draw do
  get 'events/index'

  get 'events/new'

  get 'events/edit'

  get 'events/show'

  root 'external#index'

  #sessions
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  resources :events
end
