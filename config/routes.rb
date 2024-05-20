Rails.application.routes.draw do
  get "users/show"
  devise_for :users

  get "up" => "rails/health#show", :as => :rails_health_check

  resources :dashboard, only: [:index]
  resources :posts do
    collection do
      get 'user_posts'
    end
  end
  resources :bookings

  root to: "landing#index"

  resources :conversations do
    resources :messages
  end

  resources :users, only: [:show]
  get "dashboard/map", to: "dashboard#map"
end
