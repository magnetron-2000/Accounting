Rails.application.routes.draw do

  resources :operations
  resources :logins
  resources :categories
  resources :bills
  resources :bill_types
  resources :customers
  get '/customer_with_max_bills', to: 'report#customer_with_max_bills'
  get '/deposite_bills', to: 'report#deposite_bills'
  get '/cost_moving/:id', to: 'report#cost_moving'
  get '/info_customer_with_max_sum', to: 'report#info_customer_with_max_sum'
  get '/customer_with_every_bill_type', to: 'report#customer_with_every_bill_type'
  get '/sum_for_every_customer', to: 'report#sum_for_every_customer'
  get '/bill_statistic', to: 'report#bill_statistic'
  get '/cost_moving_last_day', to: 'report#cost_moving_last_day'
end
