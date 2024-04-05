Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", :as => :rails_health_check

  resources :dashboard, only: [:index]
  resources :posts
  resources :bookings

  root to: "landing#index"

  resources :conversations do
    resources :messages
  end
end
