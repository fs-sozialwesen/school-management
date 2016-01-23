Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  root to: 'visitors#index'
  devise_for :logins
  resources :logins
  resources :people
  resources :employees
  resources :teachers
  resources :students
  resources :courses

  resources :timetables, only: [:index, :show]
  resources :internship_positions, only: [:index, :show]
  resources :candidates do
    member do
      patch :init
      patch :accept
      match :reject, via: [:get, :patch]
    end
  end

end
