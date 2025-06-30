Rails.application.routes.draw do
  # Created 11/28/2024 by Yuxi Lin
  devise_for :users
  # Admin-only route to list all users
  namespace :admin do
    resources :users, only: [ :index ] do
      member do
        patch :update_user_role
        delete :delete_user
      end
    end
  end

  resources :listings do
    resources :favorites, only: [ :create, :destroy ]
    # Routes for Multi-Step Editing
    member do
      patch :toggle_status
      get "edit_step1", to: "listings#edit_step1"
      post "edit_step1", to: "listings#save_step1", as: :save_step1
      get "edit_step2", to: "listings#edit_step2"
      post "edit_step2", to: "listings#save_step2", as: :save_step2
      get "edit_step3", to: "listings#edit_step3"
      post "edit_step3", to: "listings#save_step3", as: :save_step3
      get "edit_step4", to: "listings#edit_step4"
      post "edit_step4", to: "listings#save_step4", as: :save_step4
      get "edit_step5", to: "listings#edit_step5"
      post "edit_step5", to: "listings#save_step5", as: :save_step5
    end
  end

  get "/student_search", to: "student_searches#student_search", as: "student_search"
  get "landing/home", to: "landing#home", as: "home"
  get "landing/dashboard", to: "landing#dashboard", as: "dashboard"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "users/:id/student_profile", to: "users#student_profile", as: "student_profile"
  get "users/:id/landlord_profile", to: "users#landlord_profile", as: "landlord_profile"
  get "messages/history", to: "messages#history", as: :history_messages
  get "messages/new", to: "messages#new", as: :new_message

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Messaging Feature
  resources :conversations, only: [ :index, :new, :create, :destroy ] do
    resources :messages, only: [ :index, :create, :destroy ]
  end

  # Defines the root path route ("/")
  # root "posts#index"

  root "landing#home"
end
