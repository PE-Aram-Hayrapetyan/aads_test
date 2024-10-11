# frozen_string_literal: true

Rails.application.routes.draw do
  scope :users do
    namespace :dashboard do
      resources :friends, controller: :user_friends, only: %i[index create destroy update] do
        collection do
          post :search
        end
      end
      resources :posts, controller: :posts, only: %i[index show create update destroy]
    end
  end
  devise_for :users
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index'
end
