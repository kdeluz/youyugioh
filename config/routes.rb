Rails.application.routes.draw do
  get 'pages/contact'
  get 'pages/about'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root 'products#index'

  resources :products, only: [:index, :show]

  get 'category/:category', to: 'products#category', as: 'category'
  get 'sale', to: 'products#sale', as: 'sale'
  get 'new', to: 'products#new_products', as: 'new_products'
  get 'recently_updated', to: 'products#recently_updated', as: 'recently_updated'
  get 'search', to: 'products#search', as: 'search'

  get 'contact', to: 'pages#contact', as: 'contact'
  get 'about', to: 'pages#about', as: 'about'

namespace :admin do
  get 'dashboard', to: 'admin_dashboard#index'
end


  get "up" => "rails/health#show", as: :rails_health_check
end
