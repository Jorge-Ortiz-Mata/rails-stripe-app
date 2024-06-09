Rails.application.routes.draw do
  scope :stripe do
    post '/attach/payment/method', to: 'stripe#attach_payment_method'
  end

  scope :credentials do
    get '/stripe', to: 'credentials#stripe'
    get '/firebase', to: 'credentials#firebase'
  end

  resources :customers do
    resources :payment_methods, only: %i[new destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ('/')
  root 'customers#index'
end
