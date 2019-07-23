Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :auth do
    post 'login', to: 'authentication#login'
  end

  resources :transfers, only: [:create]
  resources :accounts, only: [:show]
end
