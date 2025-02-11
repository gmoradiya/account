Rails.application.routes.draw do
  # get "appointments/index"
  # get "appointments/show"
  # get "appointments/edit"
  devise_for :users
  root "displays#daily_appointment"
  resources :users, except: [:create] do
    collection do
      get :search
      post :create_user
    end
    member do
      get :info
    end
  end
  resources :patients do
    collection do
      get :search
    end
    member do
      get :signature
      get :new_signature
      post :save_signature
      get :info
    end

    resources :follow_ups, only: [:index, :create, :new, :destroy]
    resources :appointments
  end

  resources :appointments, only: [:new, :create] do
    member do
      get :change_status
      get :prescriptions, to: 'appointments#prescriptions', defaults: { format: :js }
    end
  end
  resources :prescriptions do
    collection do
      get :search_medicines
    end
  end

  resources :medicines

  get 'daily_appointments' => 'displays#daily_appointment'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
