Rails.application.routes.draw do
  
  get 'messages/show'
  get 'messages/new'
  post 'messages/create'

  post 'sessions/login_attempt'
  
  match "signup" => "users#new", via: :get
  match "login" => "sessions#login", via: :get
  match "logout" => "sessions#logout", via: :get

  match "inbox" => "messages#inbox", via: :get
  match "sent" => "messages#sent", via: :get

  resources :users
  resources :messages

  root 'index#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
