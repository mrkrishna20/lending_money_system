require "sidekiq/web"
Rails.application.routes.draw do
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  devise_for :users
  devise_for :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'dashboards#dashboard'

  namespace :admins do
    get :dashboard
    resources :loan, only: [] do
      patch :update
      post :reject_loan
    end
  end

  namespace :users do
    get :dashboard
  end

  resources :loans, only: [:new, :create] do
    post :confirm_request
    post :reject_request
    post :repay_loan
  end
end
