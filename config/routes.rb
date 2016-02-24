Rails.application.routes.draw do

  root to: 'visitors#index'
  devise_for :logins
  resources :people, except: :index do
    resource(:login, only: %i(new create)) { patch :toggle }
    collection do
      get :managers
      get :teachers
      get :students
    end
  end
  resources :courses, shallow: true do
    match :generate_logins, via: [:get, :patch], on: :member
    resources :time_tables do
      resources :lessons, only: %i(new create edit update destroy) do
        get :copy, on: :member
      end
      patch :toggle, on: :member
    end
  end

  resources :internship_positions
  
  resources :candidates do
    member do
      # patch :init
      patch :accept
      get :reject
    end
  end

  resources :my_time_tables, only: [:index, :show]
  resources :teacher_time_tables, only: [:index, :show]
  resources :time_blocks
  resources :subjects
  resources :rooms

end
