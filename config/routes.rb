Rails.application.routes.draw do
  # Devise routes for sellers, using custom controller
  devise_for :users, controllers: {
    registrations: 'sellers_auth/registrations'
  }, skip: [:registrations]

  # Custom seller auth routes
  devise_scope :user do
    namespace :sellers_auth, path: 'sellers' do
      get  'register', to: 'registrations#new',    as: :registration
      post 'register', to: 'registrations#create'
      get  'login',    to: 'sessions#new',         as: :login
      post 'login',    to: 'sessions#create'
    end
  end

  # Seller Dashboard route
  namespace :dashboard do
    get 'seller', to: 'seller#index', as: :seller_dashboard
  end

  # Root path
  root "home#index"
end
