require 'sidekiq/web'
require 'sidekiq-status/web'

Rails.application.routes.draw do
  
  
  ActiveAdmin.routes(self)
  devise_for :users,controllers: { registrations: 'registrations' }
  resources :categories do
    match "/update_data/:category_id" => "categories#update_data",   as: :update_data, via: :get
    match "/graph/update_data/:graph_name" => "graphs#update_data",  as: :graph_update_data, via: :get
    resources :eod_sheets
    resources :excelsheets, only:[:new, :create]
    resources :graphs do
        resources :adts
        match "/adt/update_data/:adt_id" => "adts#update_data", as: :adt_update_data, via: :get
    end
  end
  
  resources :general_market_studies
  resources :market_internals
  resources :market_studies
  resources :interesteds
  resources :commentaries
  resources :home
  resources :transactions
  resources :users

  match "/category/api_get_sp_data/:category_id" => "categories#api_get_sp_data",  as: :api_get_adt_data, via: :get
  match "/adt/api_get_adt_data/:adt_id" => "adts#api_get_adt_data",  as: :api_get_sp_data, via: :get

  get "/paypal_return" => "transactions#paypal_return"
  post "/hook" => "transactions#paypal_hook"
  get "/active_studies" => "market_studies#active_studies"
  get "/interactive_charts" => "interactive_charts#show_page"
  get '/show_by_category/:category_id' => 'interactive_charts#show_by_category', as: :show_by_category
  get "show_paypal_info" => "users#show_paypal_info"
  
  mount Sidekiq::Web, at: '/sidekiq'

  root 'market_studies#index'
end
