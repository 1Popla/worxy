Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, sign_out_via: [:delete]

  get "up" => "rails/health#show", :as => :rails_health_check

  resources :dashboard, only: [:index]
  resources :posts
  resources :bookings

  root to: "landing#index"

  resources :conversations do
    resources :messages
  end

  resources :users, only: [:show]
  get 'dashboard/map', to: 'dashboard#map'
end
