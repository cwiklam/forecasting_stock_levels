Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  root to: 'home#landing_page'
  get '/get_products', to: 'home#get_products'
  resources :products, only: %i[index new create edit update]
  resources :orders, only: %i[index new create]
  resources :forecastings, only: %i[index show]
end
