Rails.application.routes.draw do
  get "users/show"
  devise_for :users, controllers: {registrations: "users/registrations"}
  patch 'avatar_upload', to: 'users#avatar_upload', as: 'avatar_upload'

  get "up" => "rails/health#show", :as => :rails_health_check

  resources :dashboard, only: [:index]
  resources :posts do
    member do
      post "send_request"
    end
    collection do
      get "user_posts"
      post :generate_description
    end
  end

  resources :subcategories, only: [:index]

  resources :bookings do
    collection do
      get "calendar"
    end
    member do
      post :complete_with_offered_price
      post :negotiate_price
    end
  end

  get "notifications/unread_count", to: "notifications#unread_count"

  resources :notifications, only: [:index, :show, :destroy] do
    member do
      post :accept_request
      delete :reject_request
    end
  end

  root to: "landing#index"

  resources :conversations do
    resources :messages
  end

  resources :users, only: [:show] do
    resources :opinions, only: [:new, :create]
    resources :portfolio_images, only: [:new, :create, :destroy]
  end

  get "dashboard/map", to: "dashboard#map"

  resource :user_steps, only: [:new, :create, :edit, :update]
end
