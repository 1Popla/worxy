Rails.application.routes.draw do
  get "users/show"
  devise_for :users

  get "up" => "rails/health#show", :as => :rails_health_check

  resources :dashboard, only: [:index]
  resources :posts do
    member do
      post 'send_request'
    end
    collection do
      get 'user_posts'
    end
  end
  resources :bookings

  resources :notifications, only: [:index, :show] do
    member do
      post :accept_request
      delete :reject_request
    end
  end

  root to: "landing#index"

  resources :conversations do
    resources :messages
  end

  resources :users, only: [:show]
  get "dashboard/map", to: "dashboard#map"
end
