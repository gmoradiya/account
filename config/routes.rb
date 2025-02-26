Rails.application.routes.draw do
  devise_for :users
  root "displays#index"
  resources :users, except: [ :create ] do
    collection do
      get :search
      post :create_user
    end
    member do
      get :info
    end
  end
  resources :customers do
    collection do
      get :search
    end
    member do
      get :info
    end

    resources :addresses
  end

  resources :suppliers do
    collection do
      get :search
    end
    member do
      get :info
    end
  end
  resources :countries
  resources :states
  resources :products do
    collection do
      get :search
    end

    member do
      get :info
      get :suppliers_list
      get :purchase_invoices_list
      get :job_invoices_list
      get :sales_invoices_list
    end

    resources :purchase_inventories
    resources :sales_inventories
    resources :job_inventories
  end
  resources :hsns do
    collection do
      get :search
    end
  end

  resources :sales_invoices do
    collection do
      get :search
    end
    member do
      get :info
    end
  end
  resources :purchase_invoices do
    collection do
      get :search
    end
    member do
      get :info
    end
  end
  resources :sales_return_invoices do
    collection do
      get :search
    end
    member do
      get :info
    end
  end
  resources :purchase_return_invoices do
    collection do
      get :search
    end
    member do
      get :info
    end
  end

  resources :job_invoices

  resources :organizations
  resources :payments

  # get "daily_appointments" => "displays#daily_appointment"
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
