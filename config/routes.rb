Rails.application.routes.draw do
  get "users/show"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    passwords: "users/passwords",
    sessions: "users/sessions"
  }

  patch "avatar_upload", to: "users#avatar_upload", as: "avatar_upload"

  get "up" => "rails/health#show", :as => :rails_health_check

  patch 'dashboard/update_booking_in_chart', to: 'dashboard#update_booking_in_chart'

  resources :dashboard, only: [:index]

  get 'posts/:category_slug(/:subcategory_slug)', to: 'posts#filter_by_slug', as: 'filter_posts_by_slug', constraints: ->(req) do
    Category.exists?(slug: req.params[:category_slug])
  end
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

  get 'bookings/navigation', to: 'bookings#navigation', as: 'bookings_navigation'

  resources :bookings do
    collection do
      get "calendar"
    end
    member do
      post :complete_with_offered_price
      post :negotiate_price
      post :update_final_price
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
    collection do
      post 'create_or_open'
    end
  end
  get 'search_users', to: 'conversations#search_users'

  resources :users, only: [:show] do
    resources :opinions, only: [:new, :create]
    resources :portfolio_images, only: [:new, :create, :destroy]
  end

  get "dashboard/map", to: "dashboard#map"

  resource :user_steps, only: [:new, :create, :edit, :update]
end
