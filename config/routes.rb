Rails.application.routes.draw do

  root 'external#index'

  #sessions
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  resources :events do
    resources :sponsor_donations, except: [:show]
    resources :expenses, except: [:show]
  end

  resources :sponsors
  resources :users, except: [:show] do
    get :profile, on: :collection
  end
end
