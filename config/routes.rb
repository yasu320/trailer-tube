Rails.application.routes.draw do
  get 'videos/index'
  root to: 'videos#index'
end
