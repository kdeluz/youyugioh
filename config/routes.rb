# config/routes.rb
Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root 'products#index'

  resources :products, only: [:index, :show] do
    member do
      post 'add_to_cart'
    end
  end

  resources :carts, only: [:show] do
    collection do
      delete 'remove_item/:id', to: 'carts#remove_item', as: 'remove_item'
      patch 'update_item/:id', to: 'carts#update_item', as: 'update_item'
    end
  end

  get 'category/:category', to: 'products#category', as: 'category'
  get 'sale', to: 'products#sale', as: 'sale'
  get 'new', to: 'products#new_products', as: 'new_products'
  get 'recently_updated', to: 'products#recently_updated', as: 'recently_updated'
  get 'search', to: 'products#search', as: 'search'
  
  namespace :admin do
    get 'dashboard', to: 'admin_dashboard#index'
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
