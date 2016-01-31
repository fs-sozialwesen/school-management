Rails.application.routes.draw do

  root to: 'visitors#index'
  devise_for :logins
  resources :teachers do
    resource :login, except: %i(index show)
  end
  resources :students do
    resource :login, except: %i(index show)
  end
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
