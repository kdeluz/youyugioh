Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: [:index, :show]
  get 'category/:category', to: 'products#category', as: 'category'
  get 'sale', to: 'products#sale', as: 'sale'
  get 'new', to: 'products#new_products', as: 'new_products'
  get 'recently_updated', to: 'products#recently_updated', as: 'recently_updated'
  get 'search', to: 'products#search', as: 'search'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
