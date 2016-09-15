Rails.application.routes.draw do

  root to: 'visitors#index'
  devise_for :logins
  resources :people, except: :index do
    resource(:login, only: %i(new create destroy)) { patch :toggle }
    post :add_role
    collection do
      get :managers
      get :teachers
      get :students
      get :mentors
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

  resources :candidates do
    member do
      # patch :init
      patch :accept
      get :reject
    end
  end

  resources :my_time_tables, only: [:index, :show]
  resources :teacher_time_tables, only: [:index, :show]
  resources :timetable_documents, except: :show
  resources :time_blocks, except: :show
  resources :subjects, except: :show
  resources :rooms, except: :show

  resources :organisations
  resources :internship_positions, only: [:index, :show]
  resources :institutions
  resources :internships

  resources :enums, only: [:index, :edit, :update]

  get 'search', to: 'search#index', as: :search

end
