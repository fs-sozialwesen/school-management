Rails.application.routes.draw do

  root to: 'visitors#index'
  devise_for :logins
  resources :teachers do
    resource :login, except: %i(index show) do
      patch :toggle
    end
  end
  resources :managers do
    resource :login, except: %i(index show) do
      patch :toggle
    end
  end
  resources :students do
    resource :login, except: %i(index show) do
      patch :toggle
    end
  end
  resources :courses do
    member do
      match :generate_logins, via: [:get, :patch]
    end
  end

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
