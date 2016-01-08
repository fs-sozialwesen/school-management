Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  root to: 'visitors#index'
  devise_for :logins
  resources :logins
  resources :people
  resources :timetables, only: [:index, :show]
  resources :internship_positions, only: [:index, :show]
  resources :candidates do
    member do
      match :init,      via: [:get, :patch]
      # match :approve,   via: [:get, :patch]
      # match :interview, via: [:get, :patch]
      # match :accept,    via: [:get, :patch]
      patch :repeat_interview
      patch :accept_interview
      patch :reject_interview

      match :reject,    via: [:get, :patch]
      match :cancel,    via: [:get, :patch]
    end
    end

end
