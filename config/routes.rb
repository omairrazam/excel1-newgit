require 'sidekiq/web'

Rails.application.routes.draw do
  resources :excelsheets
  ActiveAdmin.routes(self)
  devise_for :users,controllers: { registrations: 'registrations' }
  resources :categories do
    match "/update_data/:category_id" => "categories#update_data", as: :update_data, via: :get
    match "/graph/update_data/:graph_id" => "graphs#update_data",  as: :graph_update_data, via: :get
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

  get "/paypal_return" => "transactions#paypal_return"
  post "/hook" => "transactions#paypal_hook"
  get "/active_studies" => "market_studies#active_studies"
  get "/interactive_charts" => "interactive_charts#show_page"
  get '/show_by_category/:category_id' => 'interactive_charts#show_by_category', as: :show_by_category
  get "show_paypal_info" => "users#show_paypal_info"
  
  mount Sidekiq::Web, at: '/sidekiq'

  
  root 'market_studies#index'
end
