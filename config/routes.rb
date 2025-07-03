# config/routes.rb
Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'sellers_auth/registrations'
  }, skip: [:registrations]

  devise_scope :user do
    namespace :sellers_auth, path: 'sellers' do
      get 'register', to: 'registrations#new', as: :registration
      post 'register', to: 'registrations#create'
      get 'login', to: 'sessions#new', as: :login
      post 'login', to: 'sessions#create'
    end
  end

  root "home#index"
end