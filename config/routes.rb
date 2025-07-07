Rails.application.routes.draw do
  # Devise routes
  devise_for :users, controllers: {
    registrations: 'sellers_auth/registrations'
  }, skip: [:registrations]

  devise_scope :user do
    namespace :sellers_auth, path: 'sellers' do
      get  'register', to: 'registrations#new',    as: :registration
      post 'register', to: 'registrations#create'
      get  'login',    to: 'sessions#new',         as: :login
      post 'login',    to: 'sessions#create'
    end
  end

  namespace :dashboard do
    # Seller dashboard home
    get 'seller', to: 'seller#index', as: :seller_dashboard

    # ✅ Proper RESTful seller profile routes
    resource :seller_profile, only: [:show, :edit, :update]

    namespace :seller do
      resources :categories 
      resources :products
    end
  end

  root "home#index"
end
