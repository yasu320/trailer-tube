Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
  resources :users, only: [:show] do
    collection do
      get '/password/change', to: 'users#password'
      patch 'update_password'
    end
  end
  root to: 'videos#index'

  resources :videos, only: [:index, :show]
end
