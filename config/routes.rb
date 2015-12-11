Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  root to: 'visitors#index'
  devise_for :logins
  resources :logins
  resources :people
  resources :timetables, only: [:index, :show]
  resources :internship_positions, only: [:index, :show]
  namespace :role, path: '' do
    resources :candidates do
      member do
        patch :init
        patch :approve
        match :invite, via: [:get, :patch]
        patch :accept
        patch :reject
      end
    end
  end

end
