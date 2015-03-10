Rails.application.routes.draw do
  devise_for :models
  blacklight_for :catalog
  root to: "catalog#index"

  devise_for :users

  get '/admin', :to => 'admin#index', :as => "admin_index"

  get '/about', :to => 'about#index', :as => "about_us"

  get '/help', :to => 'help#index', :as => "help"

  namespace :admin do
    resources :users
  end
end
