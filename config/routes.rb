Rails.application.routes.draw do

  root to: 'visitors#index'

  devise_for :logins

  resources :logins, path: 'login', only: %i(new create destroy) do
    patch :toggle, on: :member
  end

  resources :people, except: :index do
    post :add_role
    post :toggle_intern_manager
    post :toggle_archived
    collection do
      get :managers
      get :teachers
      # get :mentors
    end
  end
  resources :students, shallow: true do
    resources :contract_terminations, only: %i(new create), module: :student
  end

  resources :courses, shallow: true do
    get :reset_db_id, on: :collection
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
  resources :internships do
  resources :mentors do
    post :toggle_archived
  end
    get :copy, on: :member
    get :export, :report, on: :collection
  end
  resources :internship_blocks, except: :show

  resources :enums, only: [:index, :edit, :update]

  get 'search', to: 'search#index', as: :search

end
