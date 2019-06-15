Rails.application.routes.draw do
  root to: 'videos#index'
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
  resources :users, only: [:show] do
    collection do
      get '/password/change', to: 'users#password'
      patch 'update_password'
    end
    get '/reviews/', to: 'reviews#user_reviews'
  end

  resources :videos, only: [:index, :show] do
    resources :reviews, only: [:index, :show, :new, :create]
    collection do
      match 'search' => 'videos#search', via: [:get, :post], as: :search
    end
  end
end
