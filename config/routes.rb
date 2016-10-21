Rails.application.routes.draw do
  
  post 'sessions/login_attempt'
  
  match "signup" => "users#new", via: :get
  match "login" => "sessions#login", via: :get
  match "logout" => "sessions#logout", via: :get

  resources :users

  root 'index#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
