Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :timetables, only: [:index, :show]
  resources :internship_positions, only: [:index]
  # get 'internship_positions/index'


end
