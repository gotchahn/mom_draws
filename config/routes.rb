Rails.application.routes.draw do
  root 'external#index'

  #sessions
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  resources :events do
    resources :sponsor_donations, except: [:show]
  end

  resources :sponsors, except: [:show]
end
