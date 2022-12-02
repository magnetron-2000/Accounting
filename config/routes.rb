Rails.application.routes.draw do

  resources :operations
  resources :logins
  resources :categories
  resources :bills
  resources :bill_types
  resources :customers
end
