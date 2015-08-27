Rails.application.routes.draw do
  resources :courses
  resources :students
  resources :teachers
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
